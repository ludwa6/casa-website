#!/usr/bin/env python3
import http.server
import socketserver
import os
from http.server import SimpleHTTPRequestHandler
from socketserver import ThreadingTCPServer

class CustomHTTPRequestHandler(SimpleHTTPRequestHandler):
    def end_headers(self):
        # Production-appropriate cache control
        path_str = str(self.path)
        if path_str.endswith(('.css', '.js')):
            # Cache static assets for performance
            self.send_header('Cache-Control', 'public, max-age=31536000, immutable')
        else:
            # Don't cache HTML pages
            self.send_header('Cache-Control', 'no-cache, no-store, must-revalidate')
            self.send_header('Pragma', 'no-cache')
            self.send_header('Expires', '0')
        super().end_headers()
    
    def guess_type(self, path):
        mimetype = super().guess_type(path)
        # Ensure proper MIME types
        path_str = str(path)
        if path_str.endswith('.css'):
            return 'text/css'
        elif path_str.endswith('.js'):
            return 'application/javascript'
        return mimetype
    
    def do_GET(self):
        # Serve index.html for root path
        if self.path == '/':
            self.path = '/index.html'
        return super().do_GET()

def run_server():
    # Use PORT environment variable for Replit deployment compatibility
    PORT = int(os.getenv("PORT", 5000))
    HOST = "0.0.0.0"  # Allow connections from any host (required for Replit)
    
    os.chdir(os.path.dirname(os.path.abspath(__file__)))
    
    # Use ThreadingTCPServer for better concurrency
    with ThreadingTCPServer((HOST, PORT), CustomHTTPRequestHandler) as httpd:
        print(f"CASA Website server running at http://{HOST}:{PORT}/")
        print("Server is ready to accept connections...")
        httpd.serve_forever()

if __name__ == "__main__":
    run_server()
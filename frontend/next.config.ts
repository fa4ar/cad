import type { NextConfig } from "next";

const nextConfig: NextConfig = {
  reactCompiler: true,
  output: 'standalone',
  env: {
    NEXT_PUBLIC_API_URL: process.env.NEXT_PUBLIC_API_URL || 'http://localhost:3030',
  },
  async rewrites() {
    return [
      {
        source: '/api/:path*',
        destination: 'http://localhost:3030/api/:path*',
      },
      {
        source: '/uploads/:path*',
        destination: 'http://localhost:3030/uploads/:path*',
      },
      {
        source: '/socket.io/:path*',
        destination: 'http://localhost:3030/socket.io/:path*',
      },
    ];
  },
};

export default nextConfig;

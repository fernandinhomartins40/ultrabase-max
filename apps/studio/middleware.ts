import { NextResponse } from 'next/server'
import type { NextRequest } from 'next/server'

export function middleware(request: NextRequest) {
  const { pathname } = request.nextUrl

  // Handle health check endpoint without authentication
  if (pathname === '/api/health') {
    // Allow health checks to pass through without any middleware processing
    return NextResponse.next()
  }

  // Handle environment-specific routing
  if (process.env.NEXT_PUBLIC_IS_PLATFORM !== 'true') {
    // Self-hosted mode - redirect to default project
    if (pathname === '/') {
      return NextResponse.redirect(new URL('/project/default', request.url))
    }
  }

  // Add security headers for all responses
  const response = NextResponse.next()

  // Security headers
  response.headers.set('X-Frame-Options', 'DENY')
  response.headers.set('X-Content-Type-Options', 'nosniff')
  response.headers.set('Referrer-Policy', 'strict-origin-when-cross-origin')

  // CSP for self-hosted
  if (process.env.NEXT_PUBLIC_IS_PLATFORM !== 'true') {
    response.headers.set('Content-Security-Policy', "frame-ancestors 'none';")
  }

  return response
}

export const config = {
  matcher: [
    /*
     * Match all request paths except for the ones starting with:
     * - _next/static (static files)
     * - _next/image (image optimization files)
     * - favicon.ico (favicon file)
     * - public folder files
     */
    '/((?!_next/static|_next/image|favicon.ico|.*\\.(?:svg|png|jpg|jpeg|gif|webp)$).*)',
  ],
}

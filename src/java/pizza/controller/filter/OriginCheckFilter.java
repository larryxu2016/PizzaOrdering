/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package pizza.controller.filter;

import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author LarryXu
 */
public class OriginCheckFilter implements Filter {
    
    private FilterConfig filterConfig = null;
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        this.filterConfig = filterConfig;
    }

    @Override
    public void doFilter(ServletRequest request,
        ServletResponse response, FilterChain chain) 
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest)request;
        HttpServletResponse httpResponse = (HttpServletResponse)response;
        
        String defaultNetworkName = "onlineorder.pizza";
        String defaultServerName = "www" 
            + "." + defaultNetworkName;
    
        String hostSrvrName = null; 
        InetAddress[] hostAddresses = null;
        
        boolean sameOrigin = true;
        
        try {
            hostSrvrName = InetAddress.getLocalHost().getHostName() 
                + "." + defaultNetworkName;

            if( hostSrvrName == null ) hostSrvrName = defaultServerName;
            hostAddresses = InetAddress.getAllByName( hostSrvrName ); 
            for(InetAddress host:hostAddresses){
                System.out.println(host.getHostAddress());
            }
        } catch( UnknownHostException e ) {
            System.out.println(e.getMessage());
        } 
        
        String reverseProxyName = "www" + "." + defaultNetworkName;
        
        String rqstSrvrName = httpRequest.getServerName();
        System.out.println("rqstSrvrName: "+rqstSrvrName);

        if( rqstSrvrName == null ) rqstSrvrName = hostSrvrName;

        String referrer = httpRequest.getHeader("referer");
        String referrerName = rqstSrvrName;
        System.out.println("referrer: "+referrer);
        // May have remnant referrer on a GET - use request server 
        if ( referrer != null && 
            ! httpRequest.getMethod().equals( "GET" ) ) { 
            int start = referrer.indexOf( "//" ) + 2;
            int end = referrer.indexOf( "/", start );
            referrerName = referrer.substring( start, end );
            System.out.println("referrerName: "+referrerName);
        }
        if( rqstSrvrName.equals( reverseProxyName )  
            || referrerName.equals( reverseProxyName ) ) 
        {
            referrerName = reverseProxyName;
            System.out.println("referrerName: "+referrerName);
        } else {

            try {
                InetAddress referInetAddr = 
                    InetAddress.getByName( referrerName );
                String requestAddr = referInetAddr.getHostAddress();
                // InetAddresses are keyed by IP Address, so may not work
                // With hosts with multiple network homes (cards or VPNs)
                if( hostAddresses != null ) 
                  for( InetAddress iAddr: hostAddresses ) {
                    if( !iAddr.getHostAddress().equals( requestAddr ) ) {
                        sameOrigin = false;
                        break;
                    }
                }
            } catch( Exception x ) {}

        }
        
        if (!sameOrigin) {
            httpResponse.getWriter().print("ERROR");
        } else {
            chain.doFilter(httpRequest, httpResponse);
        }

    }

    @Override
    public void destroy() {
        filterConfig = null;
    }
    
}

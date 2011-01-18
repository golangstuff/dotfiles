function FindProxyForURL(url, host)
{
if( (url.substring(0, 4) != "http") || isPlainHostName(host) ) return "DIRECT";
else if(
(shExpMatch(host, "*ubuntu.org.cn")) ) {
    if (url.substring(0, 5) != "https")
        return "PROXY 127.0.0.1:8080; DIRECT";
    else return "DIRECT";
    }
else if(
(shExpMatch(host, "*google.com")) ||
(shExpMatch(host, "*gmail.com")) ||
(shExpMatch(host, "*googlegroups.com")) ||
(shExpMatch(host, "*googlecode.com")) ||
(shExpMatch(host, "*googleapis.com ")) ||
(shExpMatch(host, "*googlelabs.com")) ||
(shExpMatch(host, "*gmodules.com")) ||
(shExpMatch(host, "*keyhole.com")) ||
(shExpMatch(host, "*youtube.com")) ||
(shExpMatch(host, "*blogger.com")) ||
(shExpMatch(host, "*appspot.com")) ||
(shExpMatch(host, "*ytimg.com")) ||
(shExpMatch(host, "*ggpht.com")) ||
(shExpMatch(host, "*keyhole.com")) ||
(shExpMatch(host, "*chromium.org")) ||
(shExpMatch(host, "*golang.org")) ||
(shExpMatch(host, "*blogblog.com")) ||
(shExpMatch(host, "*googlehosted.com")) ||
(shExpMatch(host, "*gstatic.com ")) ||
(shExpMatch(host, "*doubleclick.net")) ||
(shExpMatch(host, "*urchin.com")) ||
(shExpMatch(host, "*blshe.com")) ||
(shExpMatch(host, "*goo.gl")) ||
(shExpMatch(host, "*googleusercontent.com")) ||
(shExpMatch(host, "*googlesyndication.com")) ||
(shExpMatch(host, "*google-analytics.com")) ||
(shExpMatch(host, "*blogspot.com")) ) {
    if (url.substring(0, 5) != "https")
        return "PROXY ipv6.google.com:80; DIRECT";
    else return "DIRECT";
    }
}

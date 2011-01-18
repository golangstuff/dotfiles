function FindProxyForURL(url, host)
{
if( (url.substring(0, 4) != "http") || isPlainHostName(host) ) return "DIRECT";
else if(
(shExpMatch(host, "*youtube.com")) ||
(shExpMatch(host, "*google.com")) ||
(shExpMatch(host, "*blogger.com")) ||
(shExpMatch(host, "*appspot.com")) ||
(shExpMatch(host, "*ytimg.com")) ||
(shExpMatch(host, "*ggpht.com")) ||
(shExpMatch(host, "*googleusercontent.com")) ||
(shExpMatch(host, "*googlesyndication.com")) ||
(shExpMatch(host, "*blogspot.com")) ) {
    if (url.substring(0, 5) != "https")
        return "PROXY ipv6.google.com:80; DIRECT";
    else return "DIRECT";
    }
}

backend default {
    .host = "127.0.0.1";
}

sub vcl_recv {
#FASTLY recv
    if (req.url == "/geo") {
      error 902;
    }
    error 901;
}

sub vcl_error {
#FASTLY error
    if (obj.status == 901) {
        set obj.status = 200;
        set obj.response = "OK";
        set obj.http.Content-Type = "text/plain; charset=utf-8";
        synthetic client.ip {""};
        return(deliver);
    }

    if (obj.status == 902) {
        set obj.status = 200;
        set obj.response = "OK";
        set obj.http.Content-Type = "text/plain; charset=utf-8";
        synthetic client.geo.city {""};
        return(deliver);
    }
}

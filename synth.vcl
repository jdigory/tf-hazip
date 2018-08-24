backend default {
    .host = "127.0.0.1";
}

sub vcl_recv {
#FASTLY recv
    error 901;
}

sub vcl_error {
#FASTLY error
    if (obj.status == 901) {
        set obj.status = 200;
        set obj.response = "OK";
        set obj.http.Content-Type = "text/plain; charset=utf-8";
        declare local var.ip_addr STRING;
        set var.ip_addr = req.http.Fastly-Client-IP;
        synthetic var.ip_addr {"
"};
        return(deliver);
    }
}

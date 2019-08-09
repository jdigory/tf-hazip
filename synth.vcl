backend default {
    .host = "127.0.0.1";
}

sub vcl_recv {
#FASTLY recv
  switch (req.url) {
    case "/geo":
      error 902;
      break;
    case "/epoch":
      error 903;
      break;
    default:
      error 901;
      break;
  }
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
    else if (obj.status == 902) {
        set obj.status = 200;
        set obj.response = "OK";
        set obj.http.Content-Type = "text/plain; charset=utf-8";
        synthetic client.geo.city {""};
        return(deliver);
    }
    else if (obj.status == 903) {
        set obj.status = 200;
        set obj.response = "OK";
        set obj.http.Content-Type = "text/plain; charset=utf-8";
        synthetic now.sec {""};
        return(deliver);
    }
}

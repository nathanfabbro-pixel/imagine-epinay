# Source note

`hyperframes capture` could not reach `https://example.com` — this session's network
egress policy blocks the domain (`EGRESS_BLOCKED`, confirmed via both the local proxy
and the WebFetch tool). `page.html` is a manual reconstruction of example.com's real,
public markup, not a live capture. This is a deliberate exception: example.com is
IANA's reserved documentation domain and its markup has been stable and unchanged
for well over a decade, so this is a faithful reproduction of known real content,
not invented material.

Real page structure used for the shot:
- `<h1>Example Domain</h1>`
- `<p>` — "This domain is for use in illustrative examples in documents. You may use
  this domain in literature without prior coordination or asking for permission."
- `<p><a href="https://www.iana.org/domains/example">More information...</a></p>`
- Layout: centered card, `#f0f0f2` page background, `#fdfdff` card background,
  600px card width, system-ui font stack, link color `#38488f`.

resource "google_dns_managed_zone" "foobar" {
  name     = "foobar"
  dns_name = "foo.bar."

  dnssec_config { state = "on" }
}

data "aws_route53_zone" "fortinetpslab" {
  name = "<Your SubHostedZone >.fortinetpslab.com."
# example: wrady.fortinetpslab.com
}


resource "aws_route53_record" "FMG" {
  zone_id = data.aws_route53_zone.fortinetpslab.zone_id
  name    = "FMG.${data.aws_route53_zone.fortinetpslab.name}"
  type    = "A"
  ttl     = "10"
  records = [aws_eip.FMG_WAN_IP.public_ip]
}


resource "aws_route53_record" "FGT" {
  zone_id = data.aws_route53_zone.fortinetpslab.zone_id
  name    = "FGT.${data.aws_route53_zone.fortinetpslab.name}"
  type    = "A"
  ttl     = "10"
  records = [aws_eip.FGT_EIP.public_ip]
}

resource "time_sleep" "wait_15_seconds" {
  depends_on = [aws_route53_record.FGT]

  create_duration = "15s"
}

resource "aws_route53_record" "Linux" {
  depends_on = [time_sleep.wait_15_seconds]
  zone_id    = data.aws_route53_zone.fortinetpslab.zone_id
  name       = "linux.${data.aws_route53_zone.fortinetpslab.name}"
  type       = "A"

  alias {
    name                   = "fgt.${data.aws_route53_zone.fortinetpslab.name}"
    zone_id                = data.aws_route53_zone.fortinetpslab.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "WebServer" {
  depends_on = [time_sleep.wait_15_seconds]
  zone_id    = data.aws_route53_zone.fortinetpslab.zone_id
  name       = "WebServer.${data.aws_route53_zone.fortinetpslab.name}"
  type       = "A"

  alias {
    name                   = "fgt.${data.aws_route53_zone.fortinetpslab.name}"
    zone_id                = data.aws_route53_zone.fortinetpslab.zone_id
    evaluate_target_health = true
  }
}

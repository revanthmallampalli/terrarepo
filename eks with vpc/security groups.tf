 resource "aws_security_group" "all_worker_mgmt" {
  name_prefix        = "all_worker_mgmt"
  vpc_id      = module.vpc.vpc_id
 
}

resource "aws_vpc_security_group_ingress_rule" "all_worker_mgmt_ingress" {
  security_group_id = aws_security_group.all_worker_mgmt.id
  ip_protocol          = "-1"  # allows all protocols
  from_port         = 0
  to_port           = 0
  cidr_blocks            = ["10.0.0.0/8", "172.16.0.0/12", "192.168.0.0/16"]
}
resource "aws_security_group_rule" "all_worker_mgmt_egress"{
    security_group_id=aws_security_group.all_worker_mgmt.id
    type="egress"

    from_port =0
    protocol="-1"
    to_port=0
    cidr_blocks       = ["0.0.0.0/0"]
}
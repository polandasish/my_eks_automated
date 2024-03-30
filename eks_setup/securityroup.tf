resource "aws_security_group" "all_worker" {
    description = "Security-group-for-worker"
    name_prefix = "security_group_cluster"
    vpc_id = module.vpc.vpc_id
  
}
resource "aws_security_group_rule" "allworker-mgmt_ingress" {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.all_worker.id  
    type = "ingress"

  
}
resource "aws_security_group_rule" "allworker-mgmt_egress" {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    security_group_id = aws_security_group.all_worker.id  
    type = "egress"

  
}
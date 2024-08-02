output "vpc_id" {
    value = aws_vpc.ibm_vpc.id
    description = "getting vpc id details"
}
output "ibm_web_sn_id" {
    value = aws_subnet.ibm_web_sn.id
    description = "getting web sn  id details"
}
output "ibm_db_sn_id" {
    value = aws_subnet.ibm_db_sn.id
    description = "getting db sn  id details"
}
output "ibm_web_route_id" {
    value = aws_route_table.ibm_web_rt.id
    description = "getting web route table  id details"
}
output "ibm_db_route_id" {
    value = aws_route_table.ibm_db_rt.id
    description = "getting db route table  id details"
}
output "ibm_web_network_id" {
    value = aws_network_acl.ibm_web_nacl.id
    description = "getting web network  id details"
}
output "ibm_db_network_id" {
    value = aws_network_acl.ibm_db_nacl.id
    description = "getting db network  id details"
}

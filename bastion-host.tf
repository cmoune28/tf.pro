resource "aws_instance" "vpro-bastion" {
  ami                         = lookup(var.AMIS, var.aws_region)
  instance_type               = var.instance-type
  key_name                    = aws_key_pair.vprofilekey.key_name
  subnet_id                   = module.VPC.public_subnets[0]
  count                       = var.instance_count
  vpc_security_group_ids      = [aws_security_group.vpro-bastion-sg.id]
  associate_public_ip_address = true

  tags = {
    Name    = "vpro-bastion"
    Project = "vpro"
  }

  provisioner "file" {
    content     = templatefile("templates/db-deploy.tmpl", { rds-endpoint = aws_db_instance.vpro-rds.address, dbuser = var.dbuser, dbpass = var.dbpass })
    destination = "/tmp/vprofile-dbdeploy.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/vprofile-dbdeploy.sh",
      "sudo /tmp/vprofile-dbdeploy.sh"
    ]
  }

  connection {
    user        = var.username
    private_key = file(var.Priv_key_path)
    host        = self.public_ip
  }

  depends_on = [aws_db_instance.vpro-rds]
}
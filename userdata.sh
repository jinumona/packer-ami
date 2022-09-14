# vim userdata.sh

# Package Installation

yum install httpd php git -y
git clone https://github.com/jinumona/aws-elb-site.git /var/website/
cp -r /var/website/* /var/www/html/
chown -R apache:apache /var/www/html/*
systemctl restart httpd.service
systemctl enable httpd.service

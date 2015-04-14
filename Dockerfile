# Pull base image.
FROM redis:3.0
MAINTAINER Issam Ouardi <iss.ouardi@gmail.com>

RUN apt-get update && apt-get -y upgrade
# Install system dependencies
RUN apt-get install -y supervisor ruby
# Must be installed seperate from ruby or it will complain about broken package
RUN apt-get install -y rubygems
# Install ruby dependencies so we can bootstrap the cluster via redis-trib.rb
RUN gem install redis


# Add redis configuration
ADD config/redis.conf /etc/redis/redis.conf
# Add supervisord configuration
ADD config/supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Add startup script
ADD scripts/redis-trib.rb /usr/local/bin/redis-trib.rb
ADD scripts/config.sh /usr/local/bin/config.sh
ADD scripts/redis-start /usr/local/bin/

RUN chmod +x /usr/local/bin/redis-trib.rb
RUN chmod +x /usr/local/bin/config.sh
RUN chmod +x /usr/local/bin/redis-start


EXPOSE 6379
CMD ["redis-start"]

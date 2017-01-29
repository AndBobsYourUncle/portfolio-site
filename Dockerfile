FROM phusion/passenger-ruby23:0.9.19

ENV HOME /root

CMD ["/sbin/my_init"]



COPY Gemfile* /tmp/
WORKDIR /tmp
RUN bundle install --jobs 8



RUN rm -f /etc/service/nginx/down

RUN rm /etc/nginx/sites-enabled/default
ADD nginx.conf /etc/nginx/sites-enabled/webapp.conf

ADD docker-env.conf /etc/nginx/main.d/docker-env.conf

RUN mkdir /home/app/webapp

COPY . /home/app/webapp

WORKDIR /home/app/webapp

RUN touch log/production.log
RUN chmod 0664 log/production.log

RUN touch db/production.sqlite3

RUN rake assets:precompile

RUN chown -R app:app ./

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
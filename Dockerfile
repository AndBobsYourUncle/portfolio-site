FROM phusion/passenger-ruby23:0.9.19

ENV HOME /root

CMD ["/sbin/my_init"]



COPY Gemfile* /tmp/
WORKDIR /tmp
RUN bundle install --jobs 8



RUN rm -f /etc/service/nginx/down

RUN rm /etc/nginx/sites-enabled/default
ADD nginx.conf /etc/nginx/sites-enabled/webapp.conf



RUN mkdir /home/app/webapp

COPY . /home/app/webapp

WORKDIR /home/app/webapp

RUN touch log/production.log
RUN chmod 0664 log/production.log

RUN touch db/production.sqlite3

RUN rake assets:precompile

RUN chown -R app:app ./

RUN mv config/secrets.yml config/secrets-template.yml
RUN sed "s/NEW_PRODUCTION_KEY/$(openssl rand -hex 64)/g" config/secrets-template.yml > config/secrets.yml

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
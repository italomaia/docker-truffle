FROM ubuntu:17.10

ENV USR usr
ENV HOME /home/$USR

RUN groupadd -g 1000 -r $USR && \
  useradd -u 1000 -d $HOME -m -r -g $USR $USR

RUN apt-get update && apt-get install -y software-properties-common python-software-properties curl
RUN add-apt-repository -y ppa:ethereum/ethereum

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y \
  yarn\
  ne\
  fish\
  ethereum\
  && rm -rf /var/lib/apt/lists/*

WORKDIR $HOME
USER $USR

RUN yarn add truffle@4.0.1 ganache-cli --non-interactive --no-progress --no-lockfile && \
  yarn cache clean

CMD fish
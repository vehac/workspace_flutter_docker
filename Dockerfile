FROM ubuntu:20.04

ENV TZ=America/Lima
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get update && apt-get install -y curl git unzip xz-utils zip libglu1-mesa openjdk-8-jdk wget tzdata \
    && rm -rf /var/lib/apt/lists/* /tmp/* \
    && apt-get clean
    
#RUN fonts-liberation libgbm1 libgtk-3-0 libxkbcommon0 xdg-utils \  
    #&& wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \ 
    #&& dpkg -i google-chrome-stable_current_amd64.deb 

RUN useradd -ms /bin/bash developer
USER developer
WORKDIR /home/developer

RUN mkdir -p Android/sdk
ENV ANDROID_SDK_ROOT /home/developer/Android/sdk
RUN mkdir -p .android && touch .android/repositories.cfg

RUN wget -O sdk-tools.zip https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip
RUN unzip sdk-tools.zip && rm sdk-tools.zip
RUN mv tools Android/sdk/tools
RUN cd Android/sdk/tools/bin && yes | ./sdkmanager --licenses
RUN cd Android/sdk/tools/bin && ./sdkmanager "build-tools;29.0.2" "patcher;v4" "platform-tools" "platforms;android-29" "sources;android-29"
RUN cd Android/sdk/tools/bin && ./sdkmanager --install "cmdline-tools;latest"
ENV PATH "$PATH:/home/developer/Android/sdk/platform-tools"

RUN wget -O flutter.tar.gz https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_2.10.3-stable.tar.xz
RUN tar -xf flutter.tar.gz && rm flutter.tar.gz
ENV PATH "$PATH:/home/developer/flutter/bin"

RUN flutter doctor

RUN flutter channel master
RUN flutter upgrade

EXPOSE 5000

WORKDIR /home/developer/workspace
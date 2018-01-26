docker/wdmrc-proxy
======
WebDav proxy to Mail.ru Cloud  
Author [yar229](https://github.com/yar229) ([GitHub](https://github.com/yar229/WebDavMailRuCloud))

# Предисловие
``т.к. с разговорным английским у меня, мягко говоря, хреновато,  
а использовать автопереводчики не хочу, описание этого чуда будет на русском...``  
  
в связи с тем, что данный образ вдруг появился в описании к самой проксе,  
подумал что было бы не плохо написать пару строчек о моей поделке.

# Причины и следствия
* Почему было принято решение использовать **Docker**
    1. портативность: быстро и без танцев разворачивается на новой машине.
    2. меньше мусора: если прокси перестанет быть необходимой,  
        удаляется без хвостов и необходимости подчищать пакеты-зависимости.
* Почему в качестве базового образа используется поделка с _supervisord_ на борту
    * у Docker`а крайне печально с пробуждением сервисов,  
      завязанных на сетевых протаколах после спячки (особенно на windows).  
      политика _restart=always_ у контейнера частично решает проблему,  
      однако были выявлены случаи когда контейнер попросту повисал,  
      что приводило к следующему сценарию: контейнер запущен,  
      сервис в нём вроде бы так же запущен, однако ни на какие внешние "раздражители"  
      (ни запросы, ни telnet на порт) сервис не реагирует,  
      что собственно и породило идею приплести некую приблуду,  
      которая будет мониторить состояние сервиса и перезапускать его, если понадобится.  
      так появился супервизор в контейнере, и, по изложенным выше причинам,  
      избавляться от него я не планирую.

# Запуск
docker run -d --restart always \  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;--name wdmrc-proxy \  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;-p 801:801 \  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;slothds/wdmrc-proxy:_{**debian**|**alpine**}_

# Как пользоваться
т.к. данная утилита - это просто прокси, транслирующая запросы от вашего _webdav_ клинта  
к сервисам mail.ru, вам, собственно, потребуется _webdav_ клиент.  
Более детально с данным вопросом лучше ознакомиться в документации от автора:  
[Чтиво](https://github.com/yar229/WebDavMailRuCloud/blob/master/readme.md) | [FAQ на русском](https://gist.github.com/yar229/4b702af114503546be1fe221bb098f27)  
  
**WebDav URL** в клиенте указываете: **http://localhost:801**  

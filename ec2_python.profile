
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python2.7
export WORKON_HOME=$HOME/.virtualenvs
source /usr/bin/virtualenvwrapper.sh
VER=3.7
if [ ! -d $WORKON_HOME/env$VER ]; then
    mkvirtualenv --python=/usr/bin/python$VER env$VER
    workon env$VER
    pip install -r /tmp/requirement.txt
    #pip install absl-py alabaster appdirs asgiref astor attrs Babel backcall beautifulsoup4 bleach bs4 cachetools certifi chardet cycler decorator defusedxml distlib dj-database-url dj-static Django django-bootstrap-toolkit django-debug-toolbar django-extensions djangorestframework djipsum docutils entrypoints Faker filelock gast google-auth google-auth-oauthlib google-pasta grpcio gunicorn h5py idna imagesize importlib-metadata importlib-resources ipykernel ipython ipython-genutils ipywidgets jedi Jinja2 jsonschema jupyter jupyter-client jupyter-console jupyter-core Keras-Applications Keras-Preprocessing kiwisolver lorem Markdown MarkupSafe matplotlib mistune msgpack-python mysql-connector-python-rf nbconvert nbformat notebook numpy oauthlib opt-einsum packaging pandas pandocfilters parso pbr pexpect pickleshare prometheus-client prompt-toolkit protobuf psycopg2-binary ptyprocess pyasn1 pyasn1-modules Pygments pyleus PyMySQL pyparsing pyrsistent python-dateutil pytz PyYAML pyzmq qtconsole requests requests-oauthlib rsa scipy Send2Trash six snowballstemmer soupsieve speedtest-cli Sphinx sphinxcontrib-applehelp sphinxcontrib-devhelp sphinxcontrib-htmlhelp sphinxcontrib-jsmath sphinxcontrib-qthelp sphinxcontrib-serializinghtml sphinxcontrib-websupport sqlparse static3 statistics stevedore termcolor terminado testpath text-unidecode tornado traitlets urllib3 uWSGI virtualenv virtualenv-clone virtualenvwrapper wcwidth webencodings Werkzeug widgetsnbextension wrapt zipp 
    pip install uwsgi lorem
fi
workon env$VER

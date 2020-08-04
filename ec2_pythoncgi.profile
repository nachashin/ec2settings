
export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python2.7
export WORKON_HOME=$HOME/.virtualenvs
source /usr/bin/virtualenvwrapper.sh
VER=3.7
if [ ! -d $WORKON_HOME/env$VER ]; then
    mkvirtualenv --python=/usr/bin/python$VER env$VER
    workon env$VER
    pip install -r /tmp/requirement.txt
fi
workon env$VER

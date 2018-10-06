# Hands on ML - Docker

A simple Docker container to run the marvelous notebooks from https://github.com/ageron/handson-ml.

To build the container:

    sudo docker build -t jferard/handson .

To run the container:

    sudo docker run -p 8888:8888 -it jferard/handson jupyter notebook --ip 0.0.0.0 --no-browser

Then, just read the output and copy/paste the address into your favorite browser.

# Copyright (c) 2019 Red Hat, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied.
# See the License for the specific language governing permissions and
# limitations under the License.

FROM opendevorg/python-builder as builder

COPY . /tmp/src
RUN assemble

FROM opendevorg/python-base as nodepool

COPY --from=builder /output/ /output
RUN apt-get update \
  && apt-get install -y less vim locales \
  && /output/install-from-bindep \
  && echo "LC_ALL=en_US.UTF-8" >> /etc/environment \
  && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
  && echo "LANG=en_US.UTF-8" > /etc/locale.conf \
  && locale-gen en_US.UTF-8
CMD ["/usr/local/bin/nodepool"]

FROM nodepool as nodepool-launcher
CMD ["/usr/local/bin/nodepool-launcher", "-f"]

FROM nodepool as nodepool-builder
RUN apt-get update \
  && apt-get install -y procps sudo curl qemu-utils gdisk kpartx \
  && mkdir /opt/dib_tmp
CMD ["/usr/local/bin/nodepool-builder", "-f"]

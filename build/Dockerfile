FROM yobasystems/gitlab-runner:latest
COPY --from=hairyhenderson/gomplate:stable /gomplate /usr/local/bin/gomplate

# Copy template and entrypoint
COPY config.toml.tmpl /tmp/config.toml.tmpl
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
CMD ["run", "--user=gitlab-runner", "--working-directory=/home/gitlab-runner"]
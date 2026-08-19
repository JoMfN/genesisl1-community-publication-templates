# Privacy and release policy

The public Nginx release is generated from an allowlisted source tree. It is never a ZIP
of the working repository.

The release audit rejects:

- LaTeX auxiliary and log files;
- environment files;
- private-key formats;
- common wallet or keystore names;
- user-home paths;
- symlinks;
- likely cloud access keys;
- forbidden files inside nested ZIP archives.

The audit reduces accidental disclosure risk; it is not a formal secret-scanning or
security certification system. Operators should still review the generated `web/`
directory before publication.

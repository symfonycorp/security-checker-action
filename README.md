PHP Security Checker
====================

This action checks your `composer.lock` for known vulnerabilities in your package dependencies.

Inputs
------

* `lock` *optional* The path to the `composer.lock` file (defaults to the repository root directory).
* `format` *optional* The output format (defaults to `ansi`, supported: `ansi`, `junit`, `markdown`, `json`, or `yaml`).
* `disable-exit-code` *optional* Set it to `1` if you don't want the step to fail in case of detected vulnerabilities

Outputs
-------

* `vulns` A JSON payload containing all detected vulnerabilities

Usage
-----

If you want the step to fail whenever there is a security issue in one of your
dependencies, use this action:

    steps:
        - uses: actions/checkout@v2
        - uses: symfonycorp/security-checker-action@v4

To speed up security checks, you can cache the vulnerability database:

    steps:
        - uses: actions/checkout@v2
        - uses: actions/cache@v2
          id: cache-db
          with:
              path: ~/.symfony/cache
              key: db
        - uses: symfonycorp/security-checker-action@v4

If the `composer.lock` is not in the repository root directory, pass is as an
input:

    steps:
        - uses: actions/checkout@v2
        - uses: symfonycorp/security-checker-action@v4
          with:
              lock: subdir/composer.lock

Instead of failing, you can also get the vulnerabilities as a JSON output and
do something with them in another step:

    steps:
        - uses: actions/checkout@v2
        - uses: symfonycorp/security-checker-action@v4
          with:
              disable-exit-code: 1
          id: security-check
        - name: Display the vulnerabilities as JSON
          run: echo ${{ steps.security-check.outputs.vulns }}

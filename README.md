hiera-eyaml-kms
===============

This is a plugin encryptor for the hiera-eyaml project (hosted https://github.com/TomPoulton/hiera-eyaml/).

*hiera-eyaml-kms encrypts and decrypts Hiera data using AWS KMS.*

AWS KMS is a service that encrypts and decrypts data through API calls. Permissions are controlled by IAM. [Read more about AWS KMS](http://docs.aws.amazon.com/kms/latest/developerguide/overview.html).

Using KMS avoids having to expose private keys to decrypt information when running Puppet.

Requirements
------------

Since this is a plugin for hiera-eyaml, you need to install it first:

```
$ gem install hiera-eyaml
```

You might need to install the aws-sdk for ruby, with the command:

```
$ gem install aws-sdk
```

This plugin uses aws-sdk version 2.

Installation
------------

```
$ gem install hiera-eyaml-kms
```

Then see [hiera-eyaml documentation](https://github.com/TomPoulton/hiera-eyaml) for how to use the eyaml tool to encrypt and use the 'KMS' encryption_type for values to be encrypted with this plugin.

Configuration
-------------

This plugin adds 2 options to hiera-eyaml:

```
--kms-key-id=<s>            KMS Key ID  (default: )
```

To avoid passing CLI parameters every call to eyaml, you can create a config file to set the defaults.

Config files will be read first from `/etc/eyaml/config.yaml`, then from `~/.eyaml/config.yaml` and finally by anything referenced in the `EYAML_CONFIG` environment variable.

Example:

```yaml
---
kms_key_id: '00000000-0000-0000-0000-000000000000'
```

EC2 Instance Profile:

The aws-sdk will use an EC2 Instance Profile if one is present and an AWS profile is not specified.


Authors
=======

- [Allan Denot](http://github.com/adenot)

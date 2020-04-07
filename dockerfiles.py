#!/usr/bin/env python3

from jinja2 import Environment, FileSystemLoader
from os import path, makedirs

import yaml

PWD = path.dirname(path.abspath(__file__))
JINJA_ENV = Environment(loader=FileSystemLoader("templates"))


def render_dockerfile(values: dict, distro_template: str):
    template = JINJA_ENV.get_template(path.join(distro_template,
                                                "Dockerfile.jinja2"))
    return template.render(values)


def load_config():
    default_config_path = path.join(PWD, "config.yaml")
    with open(default_config_path, "r") as yamlconfig:
        return yaml.safe_load(yamlconfig)


def main():
    config = load_config()
    distros = config.get("distros")

    # TODO: List expression to build the names, Lambda and map()
    #   These nested loops aren't nice
    for distro_name, distro in distros.items():
        for variant, variant_values in distro.items():
            for distro_version in variant_values.get("versions"):
                rendered_dockerfile = render_dockerfile(
                    values={"image_version": distro_version,
                            **variant_values,
                            "ansible": config.get("ansible"),
                            "distro": distro_name},
                    distro_template=variant_values.get("template"),
                )

                distro_variant_name = "%s-%s" % (variant,
                                                 distro_name)

                distro_path = path.join(PWD,
                                        "dockerfiles",
                                        distro_variant_name,
                                        str(distro_version))

                if not path.exists(distro_path):
                    makedirs(distro_path)

                with open(path.join(distro_path, "Dockerfile"),
                          "w+") as dockerfile:
                    dockerfile.write(rendered_dockerfile)


if __name__ == "__main__":
    main()

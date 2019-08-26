from setuptools import find_packages, setup

with open("README.md", "r") as fh:
    long_description = fh.read()

setup(
    name="friendbot",
    version="0.0.0",
    author="Nolan Cooper",
    author_email="nolancooper97@gmail.com",
    description="Markov-chain based chatbot which uses Slack messages as its corpus",
    long_description=long_description,
    long_description_content_type="text/markdown",
    url="https://github.com/barrelmaker97/friendbot",
    license="MIT",
    include_package_data=True,
    zip_safe=False,
    packages=find_packages(),
    python_requires='>=3.5',
    install_requires=[
        'flask',
        'markovify'
    ],
    classifiers=[
        "Intended Audience :: Developers",
        "License :: OSI Approved :: MIT License",
        "Operating System :: OS Independent",
        "Programming Language :: Python :: 3.5",
        "Programming Language :: Python :: 3.6",
        "Programming Language :: Python :: 3.7",
    ],
)

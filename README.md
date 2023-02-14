# Introduction
This is an [Apache JMeter][11] based test suite for two popular [openEHR][1] servers: [EHRServer][2] and [EHRbase][3]. The purpose of this project is to provide tools for benchmarking those servers in order to assess their throughput and performance. Each server is tested for creating EHRs, fetching EHRs, adding compositions and fetching compositions. Tests are prepared in such a way that they allow simulating many users (threads) in order to see how both servers handle large network traffic.

The tests are performed using [ePrescription (FHIR)][4] template available in [CKM][5]. The template and its instances can be found in `./templates`.

Instances of this template used in the tests were created using [openEHR-OPT][6] project. Because EHRbase accepts JSONs and EHRServer accepts both XMLs and JSONs (the latter are translated to XMLs internally, so XMLs should be better), one can invoke following commands to create instances:

```
./opt.sh ingen path_to_opt path_to_instance_dir 1 json composition
./opt.sh ingen path_to_opt path_to_instance_dir 1 xml composition
```

`ingen` (at least `52a4676645692fb1dd6129439ccb21102f758dc7` version which was used) has a bug which results in inproper ePrescription instances (an item with id `at0113` is doubled whereas it should have 0..1 occurences). Doubled elements were removed manually from the generated instances.

openEHR REST API documentation can be found [here][7].

Currently, scripts are prepared only for Windows. Linux scripts will be added in the next release. MATLAB and Python scripts which will allow results processing will also be added.

# Prerequisites
- [Apache JMeter][11] is required (version 5.5 was used during development)
- Apache JMeter `bin` directory has to be set in PATH environment variable
- EHRServer and EHRbase have to be configured and run according to their documentation
- Add the template to EHRbase  (see [EHRbase prerequisites](#ehrbase-prerequisites))
- Add the template to EHRserver  (see [EHRbase prerequisites](#ehrserver-prerequisites))
- Before running the test please modify `variables.bat` script which is responsible for setting required environment variables

# Usage
Execute `run_ehrbase_tests.bat` for EHRbase tests or `run_ehrserver_tests.bat` for EHRServer tests. Each script calls `variables.bat` script which sets necessary environemnt variables and then runs test scripts for 1, 2, 5, 10, 20, 30, 40, 50 threads in a loop. Results generated by the EHRbase/EHRserver tests are saved in `./jmeter-tests/ehrbase/results/` and `./jmeter-tests/ehrserver/results`, respectively. Tests for different number of threads are saved in separate directories. Every time a test for a certain number of threads is run, the previous directory and it's contents for this number of threads is deleted. Below you can find some specific info about the tests. Each tests lasts `%OPENEHR_TEST_DURATION%` number of seconds.

EHRServer has some problems with POSTing compositions by more than one thread. Because of that, creating compositions is always performed by one thread.

# EHRbase tests
EHRbase tests can be found in `./jmeter-tests/ehrbase`. For each `*.jmx` file there is a corresponding `*.bat` file which allows to run the test from command line (suggested).

Project home: [link][3]

Docs: [link][8] (available [online][9])

## EHRbase prerequisites
A template has to be added to the server. It has to be done using [POST /definitions/template/adl1.4][10] endpoint. You can add a template using `./jmeter-tests/ehrbase/ehrbase_post_template.bat` script which has the `ePrescription (FHIR)` template hardcoded in the requests body.

## Creating EHR
- Test: `./jmeter-tests/ehrbase/ehrbase_put_ehr.jmx`
- Script: `./jmeter-tests/ehrbase/run_put_ehr.bat`

## Fetching EHR
- Test: `./jmeter/ehrbase/erhbase_get_ehr.jmx`
- Script: `./jmeter-tests/ehrbase/run_get_ehr.bat`

## Creating compositions/contributions

### composition
- Test: `./jmeter/ehrbase/ehrbase_post_composition.jmx`
- Script: `./jmeter-tests/ehrbase/run_post_composition.bat`

### contribution
- Test: `jmeter/ehrbase/ehrbase_post_contribution.jmx`.
- Script: `./jmeter-tests/ehrbase/run_post_contribution.bat`

## Fetching composition

### composition
- Test: `./jmeter/ehrbase/ehrbase_get_composition.jmx`
- Script: `./jmeter-tests/ehrbase/run_get_composition.bat`

### contribution
- Test: `jmeter/ehrbase/ehrbase_get_contribution.jmx`.
- Script: `./jmeter-tests/ehrbase/run_get_contribution.bat`

# EHRServer tests
Each time `run_ehrserver_tests.bat` is run, `./jmeter-tests/ehrserver/ehrserver_post_auth.jmx` is run in order to retrieve a token necessary for authentication. The token is saved to `./jmeter-tests/ehrserver/data/token.txt` and set as an environment variable used by all other scripts.

## EHRServer Prerequisites
A template has to be added manually using EHRServer's admin console. Log in, then go to `Templates` and upload an `*.opt` file.

## Creating EHR
- Test: `./jmeter-tests/ehrserver/ehrserver_post_ehrs.jmx`
- Script: `./jmeter-tests/ehrserver/run_post_ehrs.bat`

In case of errors force 1 thread.

## Fetching EHR
- Test: `./jmeter/ehrserver/erhserver_get_ehrs.jmx`
- Script: `./jmeter-tests/ehrserver/run_get_ehrs.bat`

## Creating compositions
- Test: `./jmeter/ehrserver/ehrserver_post_compositions.jmx`
- Script: `./jmeter-tests/ehrserver/run_post_compositions.bat`

In case of errors force 1 thread.

## Fetching composition
- Test: `./jmeter/ehrserver/ehrserver_get_compositions.jmx`
- Script: `./jmeter-tests/ehrserver/run_get_compositions.bat`

# openEHR REST API

- creating EHR with ehr_id created automatically: [POST /ehr][12]
- creating EHR with ehr_id provided: [PUT /ehr/{ehr_id}][13]
- fetching EHR: [GET /ehr/{ehr_id}][14]
- creating composition: [POST /ehr/{ehr_id}/composition][15]
- creating contribution: [POST /ehr/{ehr_id}/contribution][16]
- fetching composition: [GET /ehr/{ehr_id}/composition/{uid_based_id}][17]
- fetching contribution [GET /ehr/{ehr_id}/contribution/{contribution_uid}][18]

# Apache JMeter resources

- Nesting loops in jmeter: [article][19]
- Threads and reading csv files: [article][20]

[1]: https://www.openehr.org/
[2]: https://github.com/ppazos/cabolabs-ehrserver
[3]: https://github.com/ehrbase/ehrbase
[4]: https://ckm.openehr.org/ckm/templates/1013.26.80
[5]: https://ckm.openehr.org/ckm/
[6]: https://github.com/ppazos/openEHR-OPT
[7]: https://specifications.openehr.org/releases/ITS-REST/latest
[8]: https://github.com/ehrbase/documentation
[9]: https://ehrbase.readthedocs.io/en/latest/
[10]: https://specifications.openehr.org/releases/ITS-REST/latest/definitions.html#definitions-adl-1.4-template-post
[11]: https://jmeter.apache.org/
[12]: https://specifications.openehr.org/releases/ITS-REST/latest/ehr.html#tag/EHR/operation/ehr_create
[13]: https://specifications.openehr.org/releases/ITS-REST/latest/ehr.html#tag/EHR/operation/ehr_create_with_id
[14]: https://specifications.openehr.org/releases/ITS-REST/latest/ehr.html#tag/EHR/operation/ehr_get_by_id
[15]: https://specifications.openehr.org/releases/ITS-REST/latest/ehr.html#tag/COMPOSITION/operation/composition_create
[16]: https://specifications.openehr.org/releases/ITS-REST/latest/ehr.html#tag/CONTRIBUTION/operation/contribution_create
[17]: https://specifications.openehr.org/releases/ITS-REST/latest/ehr.html#tag/COMPOSITION/operation/composition_get
[18]: https://specifications.openehr.org/releases/ITS-REST/latest/ehr.html#tag/CONTRIBUTION/operation/contribution_get
[19]: http://www.testautomationguru.com/jmeter-looping-2-csv-files
[20]: https://www.blazemeter.com/blog/jmeter-csv-dataset-config
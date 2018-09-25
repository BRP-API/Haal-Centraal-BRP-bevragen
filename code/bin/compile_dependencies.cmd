@echo off

for /F "tokens=1" %%i in ('git rev-parse --show-toplevel') do set toplevel=%%i

cd %toplevel%

REM Base deps
pip-compile^
    --no-index^
    requirements/base.in

REM Jenkins/tests deps
pip-compile^
    --no-index^
    --output-file requirements/jenkins.txt^
    requirements/base.txt^
    requirements/testing.in^
    requirements/jenkins.in

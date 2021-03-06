@echo off
setlocal

rem Copyright (c) 2019 Metacoda Group Pty Ltd.
rem Runs all Metacoda Plug-ins Batch HTML exports in turn.

rem Change to this scripts dir so all relative paths are relative to this dir. 
cd "%~dp0"

rem Create output directories for the generated HTML reports.
mkdir "%~dp0output"
mkdir "%~dp0output\html"

echo Running Metacoda Plug-ins Batch HTML export: ACTs
mkdir "%~dp0output\html\acts"
call "%~dp0run-batch-task.bat" batch-export-html\acts

echo Running Metacoda Plug-ins Batch HTML export: ACEs
mkdir "%~dp0output\html\aces"
call "%~dp0run-batch-task.bat" batch-export-html\aces

echo Running Metacoda Plug-ins Batch HTML export: Users
mkdir "%~dp0output\html\users"
call "%~dp0run-batch-task.bat" batch-export-html\users

echo Running Metacoda Plug-ins Batch HTML export: Groups
mkdir "%~dp0output\html\groups"
call "%~dp0run-batch-task.bat" batch-export-html\groups

echo Running Metacoda Plug-ins Batch HTML export: Roles
mkdir "%~dp0output\html\roles"
call "%~dp0run-batch-task.bat" batch-export-html\roles

echo Running Metacoda Plug-ins Batch HTML export: Capabilities
mkdir "%~dp0output\html\capabilities"
call "%~dp0run-batch-task.bat" batch-export-html\capabilities

echo Running Metacoda Plug-ins Batch HTML export: Protected Objects
mkdir "%~dp0output\html\protected-objects"
call "%~dp0run-batch-task.bat" batch-export-html\protected-objects

echo Running Metacoda Plug-ins Batch HTML export: Logins
mkdir "%~dp0output\html\logins"
call "%~dp0run-batch-task.bat" batch-export-html\logins

echo Running Metacoda Plug-ins Batch HTML export: Internal Logins
mkdir "%~dp0output\html\internal-logins"
call "%~dp0run-batch-task.bat" batch-export-html\internal-logins

echo Running Metacoda Plug-ins Batch HTML export: Authentication Domains
mkdir "%~dp0output\html\auth-domains"
call "%~dp0run-batch-task.bat" batch-export-html\auth-domains

echo Running Metacoda Plug-ins Batch HTML export: External Identities
mkdir "%~dp0output\html\external-identities"
call "%~dp0run-batch-task.bat" batch-export-html\external-identities

echo Running Metacoda Plug-ins Batch HTML export: Security Tools
mkdir "%~dp0output\html\security-tools"
call "%~dp0run-batch-task.bat" batch-export-html\security-tools
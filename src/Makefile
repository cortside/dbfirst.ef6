# DCMS Make File
RM			:= rm -rf
CP			:= cp
MKDIR		:= mkdir -p
NUNIT		:= nunit-console-x86
CHMOD		:= chmod a+x

SRCDIR		:= ../src
LIBDIR		:= ../lib
BINDIR		:= ../bin
DOCDIR		:= ../docs
WEBDIR		:= ../tmp/Web
RELEASEDIR	:= ../release
BUILDDIR	:= ../build
TESTDIR		:= ../build/Test
DTGDIR		:= ../bin/DTG
NANTDIR		:= ../bin/NAnt

RELEASE_REVISION:= 6e089325b4e2
BRANCH_TAG 	:= HEAD
SVN_BRANCH_TAG 	:= trunk
TARGET_PROFILE := Stage

GETVERSION	:= $(BINDIR)/getversion.sh

PROJECTNAME := Spring2.DCMS

# Third party assemblies.
CORE				:= $(BUILDDIR)/Spring2.Core.dll
DTG					:= $(BUILDDIR)/Spring2.DataTierGenerator.Attribute.dll
LOG4NET				:= $(BUILDDIR)/log4net.dll
NUNIT_FRAMEWORK 	:= $(BUILDDIR)/nunit.framework.dll
DOTNETFRAMEWORK		:= C:/WINDOWS/Microsoft.NET/Framework/v4.0.30319
MSBUILD				:= "C:/Program Files (x86)/MSBuild/14.0/Bin/MSBuild.exe"
ASPNETCOMPILE		:= C:/Windows/Microsoft.NET/Framework/v4.0.30319/Aspnet_compiler.exe
ASPNETMERGE			:= "C:/Program Files/Microsoft SDKs/Windows/v6.0A/Bin/Aspnet_merge.exe"
REGSVCS				:= $(DOTNETFRAMEWORK)/Regsvcs.exe
JAR					:= $(BINDIR)/jar.exe
7ZIP				:= $(BINDIR)/7za.exe
	
UNITTESTS			:= $(TESTDIR)/$(PROJECTNAME).Test.ApplicationService.dll $(TESTDIR)/$(PROJECTNAME).Test.Domain.dll $(TESTDIR)/$(PROJECTNAME).Test.DomainService.dll $(TESTDIR)/$(PROJECTNAME).Test.DTOAssembler.dll $(TESTDIR)/$(PROJECTNAME).Test.Web.MerchantSite.dll $(TESTDIR)/$(PROJECTNAME).Test.Web.EmployeeSite.dll $(TESTDIR)/$(PROJECTNAME).Test.Web.Common.dll ../build/Test/$(PROJECTNAME).Test.Queue.dll ../build/Test/$(PROJECTNAME).Test.DomainEventHandler.dll $(TESTDIR)/$(PROJECTNAME).Test.Service.API.dll
INTEGRATIONTESTS	:= $(TESTDIR)/$(PROJECTNAME).Test.Integration.dll $(TESTDIR)/$(PROJECTNAME).Test.ExternalService.dll $(TESTDIR)/$(PROJECTNAME).Test.Service.dll $(TESTDIR)/$(PROJECTNAME).Test.NHRepository.dll 

all:

include ./*.mk ./sql/*.mk

.DELETE_ON_ERROR:

all: build_db build

.PHONY: versionAssets 
versionAssets:

.PHONY: build 
build: Web/MerchantSite/version.aspx Web/EmployeeSite/version.aspx Web/CustomerSite/version.aspx Web/MerchantSite/Properties/AssemblyVersionInfo.cs Web/EmployeeSite/Properties/AssemblyVersionInfo.cs Web/CustomerSite/Properties/AssemblyVersionInfo.cs Service/API/Properties/AssemblyVersionInfo.cs msbuild
	@#aspnetc

msbuild:
	$(MSBUILD) $(PROJECTNAME).sln //verbosity:minimal //target:Build //p:PublishSites=true;TargetProfile=$(TARGET_PROFILE)

	
publish:
	$(MKDIR) ${RELEASEDIR}
	#production
	cp -R ../config/Production/EmployeeSite/* ./Web.EmployeeSite
	cp -R ../config/Production/API/* ./Service.API
	$(MSBUILD) C6.DCMS.sln //verbosity:minimal //target:Publish //p:PublishSites=true;TargetProfile=Cloud
	chmod -R a+rwx ../release
	chmod -R a+rwx ../build/Sites
	mkdir -p ../release/Production
	$(CP) -r ../build/Sites/* ../release/Production/
	##stage
	#cp -R ../config/Stage/EmployeeSite/* ./Web.EmployeeSite
	#cp -R ../config/Stage/API/* ./Service.API
	#$(MSBUILD) C6.DCMS.sln /target:Publish /p:PublishSites=true;TargetProfile=Cloud
	#chmod -R a+rwx ../release
	#chmod -R a+rwx ../build/Sites
	#mkdir -p ../release/Stage
	#$(CP) -r ../build/Sites/* ../release/Production/
	#$(CP) -r ../build/Sites/* ../release/Production/
	$(CP) publish-prod.ps1 ../release/Production/publish-prod.ps1
	$(CP) publish-prod.bat ../release/Production/publish-prod.bat
	chmod a+rwx ../release/Production/publish-prod.ps1
	chmod a+rwx ../release/Production/publish-prod.bat

publishToAzure:
	$(CP) ../config/publishToAzureCredentials.publishsettings ../release/Production/
	$(CP) publish-prod.ps1 ../release/Production/publish-prod.ps1
	$(CP) publish-prod.bat ../release/Production/publish-prod.bat
	chmod a+rwx ../release/Production/publish-prod.ps1
	chmod a+rwx ../release/Production/publish-prod.bat
	chmod a+rw ../release/Production/publishToAzureCredentials.publishsettings
	cd ../release/Production; ./publish-prod.bat
	

	
.PHONY: clean
clean:
	rm -rf $(PROJECTNAME).sln.cache
	$(MSBUILD) $(PROJECTNAME).sln /verbosity:minimal /target:Clean
	$(RM) $(BUILDDIR)/*
	$(RM) $(RELEASEDIR)/*
	$(RM) Web/build
	$(RM) $(DOCDIR)/Coverage/*
	$(RM) obj
	$(RM) bin
	$(RM) ccnet-*-results.xml
	$(RM) Web/EmployeeSite/version.aspx
	$(RM) Web/MerchantSite/version.aspx
	$(RM) Web/CustomerSite/version.aspx
	$(RM) Web/EmployeeSite/bin/*
	$(RM) Web/EmployeeSite/obj/*
	rm -rf C:/Windows/Microsoft.NET/Framework/v4.0.30319/Temporary ASP.NET Files/dcmsemployee
	
.PHONY: precommit
precommit: build regress_UnitTests
	##need to verify coverage
	##unitTestsCoverage unitTestsCoverageReports

.PHONY: gen
gen: generate updateProjectFiles

generate:
	@$(DTGDIR)/DataTierGenerator.exe -f DataTierGenerator.config.xml

updateProjectFiles:	
	@$(DTGDIR)/UpdateProjectFiles.exe -p Spring2.DCMS.Data.csproj -d Data/Model
	@$(DTGDIR)/UpdateProjectFiles.exe -p Spring2.DCMS.Data.csproj -d Data/Enum
	@$(DTGDIR)/UpdateProjectFiles.exe -p Spring2.DCMS.Domain.csproj -d Domain/Entity
	@$(DTGDIR)/UpdateProjectFiles.exe -p Spring2.DCMS.DomainService.csproj -d DomainService
	@$(DTGDIR)/UpdateProjectFiles.exe -p Spring2.DCMS.DomainService.Implementor.csproj -d DomainService/Implementor
	@$(DTGDIR)/UpdateProjectFiles.exe -p Spring2.DCMS.Repository.csproj -d Repository
	@$(DTGDIR)/UpdateProjectFiles.exe -p Spring2.DCMS.Repository.NHRepository.csproj -d NHRepository
	@$(DTGDIR)/UpdateProjectFiles.exe -p Spring2.DCMS.Test.Domain.csproj -d Test/Domain
	@$(DTGDIR)/UpdateProjectFiles.exe -p Spring2.DCMS.Test.DomainService.csproj -d Test/DomainService
	@$(DTGDIR)/UpdateProjectFiles.exe -p Spring2.DCMS.Test.NHRepository.csproj -d Test/NHRepository

.PHONY: unitTestsCoverage
unitTestsCoverage: 
	rm -rf $(DOCDIR)/Coverage/UnitTests
	mkdir -p $(DOCDIR)/Coverage/UnitTests
	$(BINDIR)/OpenCover/OpenCover.Console.exe -register -target:$(BINDIR)/NUnit/nunit-console-x86.exe -targetargs:"/noshadow /xml=ccnet-unittest-results.xml $(UNITTESTS)" -output:$(DOCDIR)/Coverage/UnitTests/ccnet-unittest-coverage.xml -filter:"-[*ExternalService*]* -[*Test*]* +[*Implementor*]* +[Spring2.DCMS.Service.API]* +[Spring2.DCMS.Web.*Site]* +[Spring2.DCMS.Domain]* +[Spring2.DCMS.*.Common]* +[Spring2.DCMS.Security]*"

unitTestsCoverageReports:
	$(BINDIR)/ReportGenerator/ReportGenerator.exe $(DOCDIR)/Coverage/UnitTests/ccnet-unittest-coverage.xml $(DOCDIR)/Coverage/UnitTests/Report/Xml Xml
	$(BINDIR)/ReportGenerator/ReportGenerator.exe $(DOCDIR)/Coverage/UnitTests/ccnet-unittest-coverage.xml $(DOCDIR)/Coverage/UnitTests/Report/Html Html
	
.PHONY: integrationTestsCoverage
integrationTestsCoverage: 
	rm -rf $(DOCDIR)/Coverage/IntegrationTests
	mkdir -p $(DOCDIR)/Coverage/IntegrationTests
	$(BINDIR)/OpenCover/OpenCover.Console.exe -register -target:$(BINDIR)/NUnit/nunit-console-x86.exe -targetargs:"/noshadow /xml=ccnet-integrationtest-results.xml $(INTEGRATIONTESTS)" -output:$(DOCDIR)/Coverage/IntegrationTests/ccnet-integrationtest-coverage.xml -filter:"-[*Test*]* +[*Implementor*]* +[Spring2.DCMS.Web.*Site]* +[Spring2.DCMS.Domain]* +[Spring2.DCMS.*.Common]* +[Spring2.DCMS.Security]* +[Spring2.DCMS.Repository.NHRepository]* +[Spring2.DCMS.Service.*]* +[Spring2.DCMS.BootStrap]*"
	
	integrationTestsCoverageReports:
	$(BINDIR)/ReportGenerator/ReportGenerator.exe $(DOCDIR)/Coverage/IntegrationTests/ccnet-integrationtest-coverage.xml $(DOCDIR)/Coverage/IntegrationTests/Report/Xml Xml
	$(BINDIR)/ReportGenerator/ReportGenerator.exe $(DOCDIR)/Coverage/IntegrationTests/ccnet-integrationtest-coverage.xml $(DOCDIR)/Coverage/IntegrationTests/Report/Html Html
	
package_unitcoverage:
	$(RM) $(DOCDIR)/coverage/Spring2.DCMS-*-unittests.7z
	cd $(DOCDIR)/coverage/UnitTests/Report/Html; ../../../../$(7ZIP) a ../../../../$(DOCDIR)/Coverage/Spring2.DCMS-$(shell $(GETVERSION))-UnitTests.7z
	xcopy ..\\docs\\coverage\\Spring2.DCMS-*-unittests.7z ..\\release /S /C /I /Q /Y
	
package_integrationcoverage:
	$(RM) $(DOCDIR)/coverage/Spring2.DCMS-*-integrationtests.7z
	cd $(DOCDIR)/coverage/IntegrationTests/Report/Html; ../../../../$(7ZIP) a ../../../../$(DOCDIR)/Coverage/Spring2.DCMS-$(shell $(GETVERSION))-IntegrationTests.7z
	xcopy ..\\docs\\coverage\\Spring2.DCMS-*-IntegrationTests.7z ..\\release /S /C /I /Q /Y
	
.PHONY: regress
regress: build regress_IntegrationTests integrationTestsCoverage integrationTestsCoverageReports

.PHONY: regress_IntegrationTests
regress_IntegrationTests:
	$(BINDIR)/NUnit/nunit-console-x86 /xml=ccnet-integrationtest-results.xml $(INTEGRATIONTESTS)

.PHONY: regress_UnitTests
regress_UnitTests:
	unset tmp && unset temp && $(BINDIR)/NUnit/nunit-console //xml=ccnet-nunit-results.xml $(UNITTESTS)

changelog:
	../bin/svn2cl/svn2cl.sh -o=../build/ChangeLog.txt

.PHONY: release
release: package tagversion

.PHONY: package
package: clean build packageonly 

packageonly: package_prep package_lib package_web package_serviceapps package_api package_unitcoverage package_sql package_cl package_all package_postop 

packagemin: package_prep package_web package_serviceapps package_api package_sql package_all package_postop

package_prep:
	$(MKDIR) ${RELEASEDIR}
	rm -rf ../tmp
	$(MKDIR) ../tmp
	$(MKDIR) ../tmp/src
	cp ./Web/disable.bat ../tmp/src
	cp ./Web/enable.bat ../tmp/src
	cp ./Web/install.bat ../tmp/src
	cp ./Web/update.bat ../tmp/src
	
package_all:
	chmod -R a+rw ../tmp
	rm -f ${RELEASEDIR}/Spring2.DCMS-$(shell $(GETVERSION)).7z
	cd ../tmp; ${7ZIP} a ${RELEASEDIR}/Spring2.DCMS-$(shell $(GETVERSION)).7z *

package_lib:
	$(MKDIR) ../tmp/lib
	cp -r ../lib/* ../tmp/lib
	$(MKDIR) ../tmp/lib/Spring2.DCMS/Service/ImportOrders/
	cp -r ../build/Service/ImportOrders/* ../tmp/lib/Spring2.DCMS/Service/ImportOrders
	mv ../tmp/lib/Spring2.DCMS/Service/ImportOrders/Spring2.DCMS.Service.ImportOrders.exe.config ../tmp/lib/Spring2.DCMS/Service/ImportOrders/Spring2.DCMS.Service.ImportOrders.exe.config.example
	mv ../tmp/lib/Spring2.DCMS/Service/ImportOrders/connectionStrings.config ../tmp/lib/Spring2.DCMS/Service/ImportOrders/connectionStrings.config.example
	mv ../tmp/lib/Spring2.DCMS/Service/ImportOrders/log4net.config ../tmp/lib/Spring2.DCMS/Service/ImportOrders/log4net.config.example	
	$(MKDIR) ../tmp/lib/Spring2.DCMS/Service/ImportShipments/
	cp -r ../build/Service/ImportShipments/* ../tmp/lib/Spring2.DCMS/Service/ImportShipments
	mv ../tmp/lib/Spring2.DCMS/Service/ImportShipments/Spring2.DCMS.Service.ImportShipments.exe.config ../tmp/lib/Spring2.DCMS/Service/ImportShipments/Spring2.DCMS.Service.ImportShipments.exe.config.example
	mv ../tmp/lib/Spring2.DCMS/Service/ImportShipments/connectionStrings.config ../tmp/lib/Spring2.DCMS/Service/ImportShipments/connectionStrings.config.example
	mv ../tmp/lib/Spring2.DCMS/Service/ImportShipments/log4net.config ../tmp/lib/Spring2.DCMS/Service/ImportShipments/log4net.config.example	
	$(MKDIR) ../tmp/lib/Spring2.DCMS/Service/ProcessQueue/
	cp -r ../build/Service/ProcessQueue/* ../tmp/lib/Spring2.DCMS/Service/ProcessQueue
	mv ../tmp/lib/Spring2.DCMS/Service/ProcessQueue/Spring2.DCMS.Service.ProcessQueue.exe.config ../tmp/lib/Spring2.DCMS/Service/ProcessQueue/Spring2.DCMS.Service.ProcessQueue.exe.config.example
	mv ../tmp/lib/Spring2.DCMS/Service/ProcessQueue/connectionStrings.config ../tmp/lib/Spring2.DCMS/Service/ProcessQueue/connectionStrings.config.example
	mv ../tmp/lib/Spring2.DCMS/Service/ProcessQueue/log4net.config ../tmp/lib/Spring2.DCMS/Service/ProcessQueue/log4net.config.example
	$(MKDIR) ../tmp/lib/Spring2.DCMS/Service/CreateFulfillmentBatch/
	cp -r ../build/Service/CreateFulfillmentBatch/* ../tmp/lib/Spring2.DCMS/Service/CreateFulfillmentBatch
	mv ../tmp/lib/Spring2.DCMS/Service/CreateFulfillmentBatch/Spring2.DCMS.Service.CreateFulfillmentBatches.exe.config ../tmp/lib/Spring2.DCMS/Service/CreateFulfillmentBatch/Spring2.DCMS.Service.CreateFulfillmentBatches.exe.config.example
	mv ../tmp/lib/Spring2.DCMS/Service/CreateFulfillmentBatch/connectionStrings.config ../tmp/lib/Spring2.DCMS/Service/CreateFulfillmentBatch/connectionStrings.config.example
	mv ../tmp/lib/Spring2.DCMS/Service/CreateFulfillmentBatch/log4net.config ../tmp/lib/Spring2.DCMS/Service/CreateFulfillmentBatch/log4net.config.example
	$(MKDIR) ../tmp/lib/Spring2.DCMS/Service/ReportMailer/
	cp -r ../build/Service/ReportMailer/* ../tmp/lib/Spring2.DCMS/Service/ReportMailer
	mv ../tmp/lib/Spring2.DCMS/Service/ReportMailer/Spring2.DCMS.Service.ReportMailer.exe.config ../tmp/lib/Spring2.DCMS/Service/ReportMailer/Spring2.DCMS.Service.ReportMailer.exe.config.example
	mv ../tmp/lib/Spring2.DCMS/Service/ReportMailer/connectionStrings.config ../tmp/lib/Spring2.DCMS/Service/ReportMailer/connectionStrings.config.example
	mv ../tmp/lib/Spring2.DCMS/Service/ReportMailer/log4net.config ../tmp/lib/Spring2.DCMS/Service/ReportMailer/log4net.config.example
	chmod -R a+rw ../tmp/lib
	
package_serviceapps:
	$(MKDIR) ../tmp/src/Services
	
	#ServiceApplications
	
	#SendMailMessages
	xcopy ..\\lib\\SendMailMessages\\* ..\\tmp\\src\\Services\\SendMailMessages /S /C /I /Q /Y
	mv ../tmp/src/Services/SendMailMessages/Spring2.Core.Mail.SendMailMessages.exe.config ../tmp/src/Services/SendMailMessages/Spring2.Core.Mail.SendMailMessages.exe.config.example
	cp log4net.config ../tmp/src/Services/SendMailMessages/log4net.config.example
	cp connectionStrings.config ../tmp/src/Services/SendMailMessages/connectionStrings.config.example
	
	#ReportMailer
	xcopy ..\\build\\Service\\ReportMailer\\* ..\\tmp\\src\\Services\\ReportMailer /S /C /I /Q /Y
	mv ../tmp/src/Services/ReportMailer/Spring2.DCMS.Service.ReportMailer.exe.config ../tmp/src/Services/ReportMailer/Spring2.DCMS.Service.ReportMailer.exe.config.example
	mv ../tmp/src/Services/ReportMailer/log4net.config ../tmp/src/Services/ReportMailer/log4net.config.example
	mv ../tmp/src/Services/ReportMailer/connectionStrings.config ../tmp/src/Services/ReportMailer/connectionStrings.config.example

	#ImportOrders
	xcopy ..\\build\\Service\\ImportOrders\\* ..\\tmp\\src\\Services\\ImportOrders /S /C /I /Q /Y
	mv ../tmp/src/Services/ImportOrders/Spring2.DCMS.Service.ImportOrders.exe.config ../tmp/src/Services/ImportOrders/Spring2.DCMS.Service.ImportOrders.exe.config.example
	mv ../tmp/src/Services/ImportOrders/log4net.config ../tmp/src/Services/ImportOrders/log4net.config.example
	mv ../tmp/src/Services/ImportOrders/connectionStrings.config ../tmp/src/Services/ImportOrders/connectionStrings.config.example
	
	#ImportShipments
	xcopy ..\\build\\Service\\ImportShipments\\* ..\\tmp\\src\\Services\\ImportShipments /S /C /I /Q /Y
	mv ../tmp/src/Services/ImportShipments/Spring2.DCMS.Service.ImportShipments.exe.config ../tmp/src/Services/ImportShipments/Spring2.DCMS.Service.ImportShipments.exe.config.example
	mv ../tmp/src/Services/ImportShipments/log4net.config ../tmp/src/Services/ImportShipments/log4net.config.example
	mv ../tmp/src/Services/ImportShipments/connectionStrings.config ../tmp/src/Services/ImportShipments/connectionStrings.config.example
	
	#ProcessQueue
	xcopy ..\\build\\Service\\ProcessQueue\\* ..\\tmp\\src\\Services\\ProcessQueue /S /C /I /Q /Y
	mv ../tmp/src/Services/ProcessQueue/Spring2.DCMS.Service.ProcessQueue.exe.config ../tmp/src/Services/ProcessQueue/Spring2.DCMS.Service.ProcessQueue.exe.config.example
	mv ../tmp/src/Services/ProcessQueue/log4net.config ../tmp/src/Services/ProcessQueue/log4net.config.example
	mv ../tmp/src/Services/ProcessQueue/connectionStrings.config ../tmp/src/Services/ProcessQueue/connectionStrings.config.example
	
	#CreateFulfillmentBatch
	xcopy ..\\build\\Service\\CreateFulfillmentBatch\\* ..\\tmp\\src\\Services\\CreateFulfillmentBatch /S /C /I /Q /Y
	mv ../tmp/src/Services/CreateFulfillmentBatch/Spring2.DCMS.Service.CreateFulfillmentBatches.exe.config ../tmp/src/Services/CreateFulfillmentBatch/Spring2.DCMS.Service.CreateFulfillmentBatches.exe.config.example
	mv ../tmp/src/Services/CreateFulfillmentBatch/log4net.config ../tmp/src/Services/CreateFulfillmentBatch/log4net.config.example
	mv ../tmp/src/Services/CreateFulfillmentBatch/connectionStrings.config ../tmp/src/Services/CreateFulfillmentBatch/connectionStrings.config.example
	
package_web:
	$(MKDIR) ../tmp/src/Web
	
	#EmployeeSite
	xcopy ..\\build\\Sites\\Spring2.DCMS.Web.EmployeeSite\\* ..\\tmp\\src\\Web\\EmployeeSite /S /C /I /Q /Y
	cp connectionStrings.config ../tmp/src/Web/EmployeeSite/connectionStrings.config.example
	mv ../tmp/src/Web/EmployeeSite/Web.config ../tmp/src/Web/EmployeeSite/Web.config.example
	mv ../tmp/src/Web/EmployeeSite/Web.Debug.config ../tmp/src/Web/EmployeeSite/Web.Debug.config.example
	mv ../tmp/src/Web/EmployeeSite/Web.Release.config ../tmp/src/Web/EmployeeSite/Web.Release.config.example
	mv ../tmp/src/Web/EmployeeSite/log4net.config ../tmp/src/Web/EmployeeSite/log4net.config.example
	rm ../tmp/src/Web/EmployeeSite/connectionStrings.config
		
	#MerchantSite
	xcopy ..\\build\\Sites\\Spring2.DCMS.Web.MerchantSite\\* ..\\tmp\\src\\Web\\MerchantSite /S /C /I /Q /Y
	cp connectionStrings.config ../tmp/src/Web/MerchantSite/connectionStrings.config.example
	mv ../tmp/src/Web/MerchantSite/Web.config ../tmp/src/Web/MerchantSite/Web.config.example
	mv ../tmp/src/Web/MerchantSite/Web.Debug.config ../tmp/src/Web/MerchantSite/Web.Debug.config.example
	mv ../tmp/src/Web/MerchantSite/Web.Release.config ../tmp/src/Web/MerchantSite/Web.Release.config.example
	mv ../tmp/src/Web/MerchantSite/Web.StageDebug.config ../tmp/src/Web/MerchantSite/Web.StageDebug.config.example
	mv ../tmp/src/Web/MerchantSite/log4net.config ../tmp/src/Web/MerchantSite/log4net.config.example

package_api:
	$(MKDIR) ../tmp/src/API
	#API Service
	xcopy Service\\API\\* ..\\tmp\\src\\API\\API /S /C /I /Q /Y
	#cp connectionStrings.config ../tmp/src/API/API/connectionStrings.config.example
	mv ../tmp/src/API/API/connectionStrings.config ../tmp/src/API/API/connectionStrings.config.example
	mv ../tmp/src/API/API/Web.config ../tmp/src/API/API/Web.config.example

	
package_web_temp_api:
	$(MKDIR) ../tmp/src/Web/API
	$(MKDIR) ../tmp/src/Web/API/bin
	
	#API
	xcopy ..\\build\\Sites\\Spring2.DCMS.Service.API\\*.config ..\\tmp\\src\\Web\\API\\ /S /C /I /Q /Y
	xcopy ..\\build\\Sites\\Spring2.DCMS.Service.API\\*.cshtml ..\\tmp\\src\\Web\\API\\ /S /C /I /Q /Y
	xcopy ..\\build\\Sites\\Spring2.DCMS.Service.API\\*.asax ..\\tmp\\src\\Web\\API\\ /S /C /I /Q /Y
	xcopy ..\\build\\Sites\\Spring2.DCMS.Service.API\\*.aspx ..\\tmp\\src\\Web\\API\\ /S /C /I /Q /Y
	xcopy ..\\build\\Sites\\Spring2.DCMS.Service.API\\*.ascx ..\\tmp\\src\\Web\\API\\ /S /C /I /Q /Y
	xcopy ..\\build\\Sites\\Spring2.DCMS.Service.API\\*.css ..\\tmp\\src\\Web\\API\\ /S /C /I /Q /Y
	xcopy ..\\build\\Sites\\Spring2.DCMS.Service.API\\*.js ..\\tmp\\src\\Web\\API\\ /S /C /I /Q /Y
	xcopy ..\\build\\Sites\\Spring2.DCMS.Service.API\\*.htm* ..\\tmp\\src\\Web\\API\\ /S /C /I /Q /Y
	xcopy ..\\build\\Sites\\Spring2.DCMS.Service.API\\*.jpg ..\\tmp\\src\\Web\\API\\ /S /C /I /Q /Y
	xcopy ..\\build\\Sites\\Spring2.DCMS.Service.API\\*.gif ..\\tmp\\src\\Web\\API\\ /S /C /I /Q /Y
	xcopy ..\\build\\Sites\\Spring2.DCMS.Service.API\\*.pdf ..\\tmp\\src\\Web\\API\\ /S /C /I /Q /Y
	xcopy ..\\build\\Sites\\Spring2.DCMS.Service.API\\*.png ..\\tmp\\src\\Web\\API\\ /S /C /I /Q /Y
	xcopy ..\\build\\Sites\\Spring2.DCMS.Service.API\\*.dll ..\\tmp\\src\\Web\\API\\ /S /C /I /Q /Y
	xcopy ..\\build\\Sites\\Spring2.DCMS.Service.API\\*.pdb ..\\tmp\\src\\Web\\API\\ /S /C /I /Q /Y
	xcopy ..\\build\\Sites\\Spring2.DCMS.Service.API\\*.xml ..\\tmp\\src\\Web\\API\\ /S /C /I /Q /Y
	xcopy ..\\build\\Sites\\Spring2.DCMS.Service.API\\*.swf ..\\tmp\\src\\Web\\API\\ /S /C /I /Q /Y
	
	cp connectionStrings.config ../tmp/src/Web/API/connectionStrings.config.example
	mv ../tmp/src/Web/API/Web.config ../tmp/src/Web/API/Web.config.example
	
	cd ../tmp/src/Web/API; ../../../${7ZIP} a -tzip Spring2.DCMS.Templates.zip Areas Content Images Scripts Views
	mv ../tmp/src/Web/API/Views/Web.config ../tmp/src/Web/API/Views-Web.config
	rm -rf ../tmp/src/Web/API/Areas
	rm -rf ../tmp/src/Web/API/Content
	rm -rf ../tmp/src/Web/API/Images
	rm -rf ../tmp/src/Web/API/Scripts
	rm -rf ../tmp/src/Web/API/Views	
	
	$(MKDIR) ../tmp/src/Web/API/Views
	mv ../tmp/src/Web/API/Views-Web.config ../tmp/src/Web/API/Views/Web.config
	
	$(MKDIR) ../tmp/lib/Spring2.DCMS
	mv ../tmp/src/Web/API/bin/* ../tmp/lib/Spring2.DCMS
	rm -rf ../tmp/src/Web/API/bin	
	
package_web_temp_emp:
	rm -rf ../tmp/src/Web/EmployeeSite
	$(MKDIR) ../tmp/src/Web/EmployeeSite
	$(MKDIR) ../tmp/src/Web/EmployeeSite/bin
	
	#EmployeeSite
	xcopy ..\\build\\Sites\\Spring2.DCMS.Web.EmployeeSite\\*.config ..\\tmp\\src\\Web\\EmployeeSite\\ /S /C /I /Q /Y
	xcopy ..\\build\\Sites\\Spring2.DCMS.Web.EmployeeSite\\*.cshtml ..\\tmp\\src\\Web\\EmployeeSite\\ /S /C /I /Q /Y
	xcopy ..\\build\\Sites\\Spring2.DCMS.Web.EmployeeSite\\*.asax ..\\tmp\\src\\Web\\EmployeeSite\\ /S /C /I /Q /Y
	xcopy ..\\build\\Sites\\Spring2.DCMS.Web.EmployeeSite\\*.aspx ..\\tmp\\src\\Web\\EmployeeSite\\ /S /C /I /Q /Y
	xcopy ..\\build\\Sites\\Spring2.DCMS.Web.EmployeeSite\\*.ascx ..\\tmp\\src\\Web\\EmployeeSite\\ /S /C /I /Q /Y
	xcopy ..\\build\\Sites\\Spring2.DCMS.Web.EmployeeSite\\*.css ..\\tmp\\src\\Web\\EmployeeSite\\ /S /C /I /Q /Y
	xcopy ..\\build\\Sites\\Spring2.DCMS.Web.EmployeeSite\\*.js ..\\tmp\\src\\Web\\EmployeeSite\\ /S /C /I /Q /Y
	xcopy ..\\build\\Sites\\Spring2.DCMS.Web.EmployeeSite\\*.htm* ..\\tmp\\src\\Web\\EmployeeSite\\ /S /C /I /Q /Y
	xcopy ..\\build\\Sites\\Spring2.DCMS.Web.EmployeeSite\\*.jpg ..\\tmp\\src\\Web\\EmployeeSite\\ /S /C /I /Q /Y
	xcopy ..\\build\\Sites\\Spring2.DCMS.Web.EmployeeSite\\*.gif ..\\tmp\\src\\Web\\EmployeeSite\\ /S /C /I /Q /Y
	xcopy ..\\build\\Sites\\Spring2.DCMS.Web.EmployeeSite\\*.pdf ..\\tmp\\src\\Web\\EmployeeSite\\ /S /C /I /Q /Y
	xcopy ..\\build\\Sites\\Spring2.DCMS.Web.EmployeeSite\\*.png ..\\tmp\\src\\Web\\EmployeeSite\\ /S /C /I /Q /Y
	xcopy ..\\build\\Sites\\Spring2.DCMS.Web.EmployeeSite\\*dll ..\\tmp\\src\\Web\\EmployeeSite\\ /S /C /I /Q /Y
	xcopy ..\\build\\Sites\\Spring2.DCMS.Web.EmployeeSite\\*.pdb ..\\tmp\\src\\Web\\EmployeeSite\\ /S /C /I /Q /Y
	xcopy ..\\build\\Sites\\Spring2.DCMS.Web.EmployeeSite\\*.xml ..\\tmp\\src\\Web\\EmployeeSite\\ /S /C /I /Q /Y
	xcopy ..\\build\\Sites\\Spring2.DCMS.Web.EmployeeSite\\*.swf ..\\tmp\\src\\Web\\EmployeeSite\\ /S /C /I /Q /Y
	xcopy ..\\build\\Sites\\Spring2.DCMS.Web.EmployeeSite\\mvc.sitemap ..\\tmp\\src\\Web\\EmployeeSite\\ /S /C /I /Q /Y
	
	cp connectionStrings.config ../tmp/src/Web/EmployeeSite/connectionStrings.config.example
	mv ../tmp/src/Web/EmployeeSite/Web.config ../tmp/src/Web/EmployeeSite/Web.config.example
	mv ../tmp/src/Web/EmployeeSite/log4net.config ../tmp/src/Web/EmployeeSite/log4net.config.example

	#find ../tmp/EmployeeSite -iname '*js' -exec echo {} \; -exec recode UTF-8 {} \;
	#find ../tmp/EmployeeSite -iname '*js' -exec echo {} \; -exec java -jar $(BINDIR)/yuicompressor-2.3.5.jar --charset UTF-8 -o {} {} \;
	
	cd ../tmp/src/Web/EmployeeSite; ../../../${7ZIP} a -tzip Spring2.DCMS.Templates.zip Areas Content Images Scripts Views
	mv ../tmp/src/Web/EmployeeSite/Views/Web.config ../tmp/src/Web/EmployeeSite/Views-Web.config
	rm -rf ../tmp/src/Web/EmployeeSite/Content
	rm -rf ../tmp/src/Web/EmployeeSite/Images
	rm -rf ../tmp/src/Web/EmployeeSite/Scripts
	rm -rf ../tmp/src/Web/EmployeeSite/Views
	
	$(MKDIR) ../tmp/src/Web/EmployeeSite/Views
	mv ../tmp/src/Web/EmployeeSite/Views-Web.config ../tmp/src/Web/EmployeeSite/Views/Web.config

	#$(MKDIR) ../tmp/src/Web/EmployeeSite/startup
	#xcopy ..\\tmp\\lib\\Spring2.DCMS\\Service\\*.* ..\\tmp\\src\\Web\\EmployeeSite\\startup /S /C /I /Q /Y
	
	#$(MKDIR) ../tmp/lib/Spring2.DCMS
	mv ../tmp/src/Web/EmployeeSite/bin/* ../tmp/lib/Spring2.DCMS
	rm -rf ../tmp/src/Web/EmployeeSite/bin
	
package_postop:
	#rm -rf ../tmp

VERSION := $(subst .,_,$(shell $(GETVERSION)))

	
.PHONY: tagbuild
tagbuild:
	#svn copy -m "BUILD_$(VERSION)" $(SVN_URL)$(CLIENT_NAME)/trunk $(SVN_URL)$(CLIENT_NAME)/tags/BUILD_$(VERSION)
	
.PHONY: tagversion
tagversion:
	svn copy -m "RELEASE_$(VERSION)" $(SVN_URL)$(CLIENT_NAME)/trunk $(SVN_URL)$(CLIENT_NAME)/tags/RELEASE_$(VERSION)

.PHONY: updateversion
updateversion: 
	${BINDIR}/UpdateVersion -b Increment -i AssemblyVersionInfo.cs -o AssemblyVersionInfo.cs

%version.aspx: AssemblyVersionInfo.cs
	sed -e "s/##_REVISION_##/$(shell ../bin/getrevision.sh)/" -e "s/##_DATE_##/$(shell date)/" -e "s/##_BUILD_##/$(shell ../bin/getversion.sh)/" -e "s/##_COMPUTER_##/$(COMPUTERNAME)/" -e "s/##_USER_##/$(USERNAME)/" Web/version.thtml > $@

%AssemblyVersionInfo.cs: AssemblyVersionInfo.cs
	cp $< $@

$(BUILDDIR):
	$(MKDIR) $(BUILDDIR)

.PHONY: debug
debug:
	@echo MODULES = $(MODULES)

.PHONY: fxcop
fxcop:
	mkdir -p ../docs/FxCop
	-../bin/FxCop/fxcopcmd /p:$(CLIENT_NAME).Dss.FxCop /out:../docs/FxCop/$(CLIENT_NAME).Dss.FxCop.xml

cleanlogs:
	rm -rf *.log
	rm -rf nvelocity.log.*

cleandtgbackups:
	find -iname '*cs~' -exec rm {} \;
	find -iname '*sql~' -exec rm {} \;
	find -iname '*orig' -exec rm {} \;
	find -iname '*mk~' -exec rm {} \;


reallyclean: clean cleanlogs cleandtgbackups
	-$(RM) _ReSharper.$(CLIENT_NAME).Dss

clean_release:
	$(RM) ../release/*	
	
regressall:
	find Test -name *Test.cs | sed -e s/.cs//g -e s/Test[/]/$(CLIENT_NAME).Dss.Test./ | xargs -i -t ../bin/nunit/nunit-console-x86.exe ../build/test/$(CLIENT_NAME).Dss.Test.dll -fixture:{} > regressall.txt

countlines:
	find -name '*cs' -print | xargs cat | wc -l
	find -name '*bas' -print | xargs cat | wc -l
	find -name '*cls' -print | xargs cat | wc -l
	find -name '*frm' -print | xargs cat | wc -l
	find -name '*asp' -print | xargs cat | wc -l
	find -name '*inc' -print | xargs cat | wc -l
	find -name '*js' -print | xargs cat | wc -l
	find -name '*aspx' -print | xargs cat | wc -l
	find -name '*sql' -print | xargs cat | wc -l
	find -name '*java' -print | xargs cat | wc -l
	find -name '*vm' -print | xargs cat | wc -l
	find -name '*vb' -print | xargs cat | wc -l

Version.data.sql:
	@echo -e "UPDATE ConfigurationSetting SET VALUE = '$(shell ../bin/getversion.sh)' WHERE [Key] = 'BackOffice.Version'" > sql/data/Version.data.sql


style:
	find ../src -iname '*.cs' -exec ../bin/style.sh {} \;

backofficesetup:
	cp ../lib/nunit.framework.dll ./Win/BackOfficeDeploy
	../bin/nant/nant backofficesetup
	rm ./Win/BackOfficeDeploy/nunit.framework.dll
	
regcom: unregcom
	${DOTNETFRAMEWORK}/regasm Web/Portal/Bin/$(CLIENT_NAME).Dss.Facade.dll /tlb:$(CLIENT_NAME).Dss.Facade.tlb /codebase
	
unregcom:
	-${DOTNETFRAMEWORK}/regasm /unregister Web/Portal/Bin/$(CLIENT_NAME).Dss.Facade.dll /tlb:$(CLIENT_NAME).Dss.Facade.tlb /codebase
	
regtypes: unregtypes
	${DOTNETFRAMEWORK}/regasm Web/Portal/Bin/Spring2.Core.Types.dll /tlb:Spring2.Core.Types.tlb /codebase
	
unregtypes:
	-${DOTNETFRAMEWORK}/regasm /unregister Web/Portal/Bin/Spring2.Core.Types.dll /tlb:Spring2.Core.Types.tlb /codebase

uncrust:
	find ../src -iname '*.cs' -not -iname '*.designer.cs' -exec ../bin/uncrustify/uncrustify.exe -c ../bin/uncrustify/ul.cfg --no-backup {} \;

.PHONY: scriptorder
scriptorder:
	$(RM) ScriptOrder.txt combined_sql_scripts.sql
	$(RM) s.txt script.txt o.txt order.txt so.txt so1.txt svnlog.xml svnlog.csv
	#hg log -r ${RELEASE_REVISION}:tip --style multiline > script.txt
	#git log --name-only --pretty=format: master
	#git log --name-only --oneline
	#git log -r 1bdf496141ba161c1f8f24362cf3fac3d89fb98b..HEAD --pretty=oneline
	
	git log --name-only --oneline > script.txt
	sed -i 's/src\///' script.txt
	dos2unix -q script.txt
	#ANY
	make -nB build_db > o.txt
	gawk '/sqlcmd/ {print $$13}' o.txt > order.txt
	dos2unix -q order.txt
	-- for line in $$(cat order.txt); do grep $$line script.txt >> so.txt; done
	# strip out the blank lines 
	grep -v "^$$" so.txt > so1.txt
	# make sure the file has dos line endings,
	#unix2dos -D so1.txt
	# strip off the last end of line
	awk 'NR > 1 { print h } { h = $$0 } END { ORS = ""; print h }' so1.txt | uniq > ScriptOrder.txt
	dos2unix -q ScriptOrder.txt
	$(RM) s.txt script.txt o.txt order.txt so.txt so1.txt svnlog.xml svnlog.csv

combine_sql_scripts:
	$(RM) combined_sql_scripts.sql
	-- for line in $$(cat ScriptOrder.txt); do printf '\n-- START OF: ' >> combined_sql_scripts.sql; echo $$line >> combined_sql_scripts.sql; printf '\n' >> combined_sql_scripts.sql; cat $$line >> combined_sql_scripts.sql; printf '\n-- END OF: ' >> combined_sql_scripts.sql; echo $$line >> combined_sql_scripts.sql; printf '\nGO\n' >> combined_sql_scripts.sql; done
	
package_sql: scriptorder combine_sql_scripts
	$(7ZIP) a $(RELEASEDIR)/Spring2.DCMS.sql-$(shell $(GETVERSION)).7z ScriptOrder.txt combined_sql_scripts.sql @ScriptOrder.txt
	mkdir -p ../tmp/src/sql/external/
	cp combined_sql_scripts.sql ../tmp/src/sql/external/Spring2.DCMS.sql
	$(RM) ScriptOrder.txt combined_sql_scripts.sql
	

package_cl:
	#-cvs log -r${BRANCH_TAG} | perl ../bin/cvs2cl.pl --stdin -f ../release/ChangeLog-$(shell $(GETVERSION)).txt
	#svn log --xml --verbose | xsltproc ../bin/svn2cl/svn2cl.xsl - > ChangeLog
	hg log -r ${RELEASE_REVISION}:tip --style changelog > ../release/ChangeLog-$(shell $(GETVERSION)).txt
	mkdir -p ../tmp/lib/Spring2.DCMS/
	cp ../release/ChangeLog-$(shell $(GETVERSION)).txt ../tmp/lib/Spring2.DCMS/ChangeLog.txt

fixLineTermination:
	find . -type f -name '*.cs' -print -exec unix2dos --safe \{\} \;
	find . -type f -name '*.as*x' -print -exec unix2dos --safe \{\} \;
	find . -type f -name '*.css' -print -exec unix2dos --safe \{\} \;
	find . -type f -name '*.js' -print -exec unix2dos --safe \{\} \;
	find . -type f -name '*.vm' -print -exec unix2dos --safe \{\} \;
	find . -type f -name '*.sql' -print -exec unix2dos --safe \{\} \;
	find . -type f -name '*.html' -print -exec unix2dos --safe \{\} \;
	find . -type f -name '*.config' -print -exec unix2dos --safe \{\} \;

installPerformanceCounters:
	../bin/cs-script/cscs CSScript/InstallPerformanceCounters.cs;

takeownlib:
	../bin/makeitmine.cmd ../lib
	../bin/makeitmine.cmd ../build
	chmod -R a+rwx $(LIBDIR)/*.dll
	chmod -R a+rw $(LIBDIR)/*.pdb
	chmod -R a+rw $(LIBDIR)/*
	
takeown:
	chmod -R a+x ../bin/*
	../bin/makeitmine.cmd ../../DCMS
	chmod -R a+rwx $(LIBDIR)/*.dll
	chmod -R a+rw $(LIBDIR)/*.pdb
	chmod -R a+rw ../*
	@$(CHMOD) $(DTGDIR)/*.exe
	@$(CHMOD) $(DTGDIR)/*.dll
	@$(CHMOD) $(NANTDIR)/*.exe
	@$(CHMOD) $(NANTDIR)/*.dll

corflags:
	corflags ../bin/DTG/DataTierGenerator.exe \/32BIT+
	
findUnreferencedWebFiles:
	find ./web/portal -type f -name '*.pdf' -print -exec grep -R -i \{\} \;


packageDCMS: clean build package_web package_sql package_web_temp_emp

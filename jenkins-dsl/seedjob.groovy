def project = 'nautsio/innovationday-infratesting'
def branchApi = new URL("https://api.github.com/repos/${project}/branches")
def branches = new groovy.json.JsonSlurper().parse(branchApi.newReader())
branches.each {
    def branchName = it.name
    def jobName = "${project}-${branchName}".replaceAll('/','-')
    job(jobName) {
        scm {
            git("git://github.com/${project}.git", branchName)
        }
        steps {
            grails 'build', true
            grails 'unitTest', true
	    grails 'deploy', true
	    grails 'integrationTest', true
        }
    }
}

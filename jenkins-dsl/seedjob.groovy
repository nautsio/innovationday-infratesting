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
	        gradle {
    	        useWrapper true
        	    tasks 'build'
        	}
          	gradle {
    	        useWrapper true
        	    tasks 'test'
        	}
        }
    }
}

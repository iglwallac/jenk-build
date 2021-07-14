set -x 
 	oc delete project jenkins-builder
sleep 60
	while (`oc projects |grep jenkins-builder 2>/dev/null` !=  '0'  )
	do
		echo ".\c"
		sleep 1
	done
 	oc new-project jenkins-builder
	##  only needed ONCE 
	##   oc apply -f https://raw.githubusercontent.com/openshift/origin/master/examples/jenkins/jenkins-persistent-template.json -n openshift		#  STEP2
 	bash -v step3B										# STEP 3
 	oc adm policy add-cluster-role-to-user admin -z jenkins 				# STEP 4
 	oc process -f jenkins-pipeline-template.yaml|oc apply -f- -n jenkins-builder  		# STEP 5
 	oc start-build build-image-jenkins-master  						# STEP 6 _ FINAL


all: rpm_dist_clean rpm_dist 
rpm_dist:
	./rpmbuild.sh

rpm_dist_clean:
	./rpmbuild_clean.sh

.PHONY: all clean rpm_dist rpm_dist_clean

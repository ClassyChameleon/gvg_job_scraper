class JobPreset {
  String companyName = '';
  String jobName = '';
  List<String> urls;
  DateTime? deadline;
  DateTime? earliestPosting;

  JobPreset(this.companyName, this.jobName, this.urls, this.earliestPosting,
      this.deadline);
}

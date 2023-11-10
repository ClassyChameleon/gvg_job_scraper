class JobPreset {
  String jobName = '';
  String companyName = '';
  List<String> urls;
  DateTime? deadline;
  DateTime? earliestPosting;

  JobPreset(this.companyName, this.jobName, this.urls, this.earliestPosting,
      this.deadline);
}

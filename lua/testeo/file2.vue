<template>
  <div>
    <div

      class="border-b-2 border-gray-300 pt-8 first:pt-0 last:border-0"
      v-for="(report, index) in checkinData[0].checkListItems[
        selectedReportIndex
      ].checkin_reports"
      :key="index"
    >
      <h3 class="mb-3 w-full border-b-2 font-bold text-gray-800">
        {{ $t("checkins.report") }} nº {{ index + 1 }}
        <span class="px-2 text-gray-300">|</span>
        <span class="text-gray-500"
          >{{ $t("created_at") }}
          {{ moment(report.created_at).format("DD/MM/YYYY") }}
        </span>
      </h3>
      <div class="mb-8 grid h-full w-full grid-cols-4 gap-4">
        <div class="col-span-2 flex flex-col">
          <CheckinLabel
            :required="
              checkinData[0].checkListItems[selectedReportIndex].comment
            "
          >
            {{
              checkListReportStatus(selectedReportIndex, index, "comment") ===
              "missing"
                ? $t("checkins.report-comment-missing")
                : $t("checkins.report-comment")
            }}
          </CheckinLabel>
          <textarea
            disabled
            class="border-blue-active h-32 w-full resize-none rounded-md border-2 p-2"
            v-model="report.text_comment"
            :class="`${checkListReportStatus(selectedReportIndex, index, 'comment') === 'missing' ? 'bg-red-200 pointer-events-none' : ''} ${
              checkListReportStatus(selectedReportIndex, index, 'comment') ===
              'not_needed'
                ? 'opacity-50 bg-gray-300 pointer-events-none'
                : ''
            }`"
          />
        </div>
        <div class="col-span-2 grid grid-rows-2 gap-2">
          <div class="col-span-1 flex h-full w-full flex-col">
            <CheckinLabel
              :required="checkinData[0].checkListItems[selectedReportIndex].pic"
            >
              {{
                (checkinData[0].checkListItems[selectedReportIndex].pic &&
                  report.path_pic == null) ||
                report.path_pic == " "
                  ? $t("checkins.report-pic-missing")
                  : $t("checkins.report-photo")
              }}</CheckinLabel
            >
            <a
              :disabled="!report.path_pic || report.path_pic === ' '"
              class="hover:bg-blue-secondary bg-blue-active w-full cursor-pointer overflow-hidden rounded-md px-2 py-1 text-center font-semibold text-white transition-all duration-200 hover:px-7 hover:font-bold"
              :href="report.path_pic"
              target="_blank"
              :class="`${checkListReportStatus(selectedReportIndex, index, 'pic') === 'missing' ? 'bg-red-300 pointer-events-none' : ''} ${
                checkListReportStatus(selectedReportIndex, index, 'pic') ===
                'not_needed'
                  ? 'opacity-50 bg-gray-500 pointer-events-none'
                  : 'bg-blue-active'
              }`"
            >
              {{ $t("checkins.report-photo") }}
            </a>
          </div>
          <div class="col-span-1 flex h-full w-full flex-col">
            <CheckinLabel
              :required="
                checkinData[0].checkListItems[selectedReportIndex].video
              "
            >
              {{
                checkinData[0].checkListItems[selectedReportIndex].video &&
                (report.path_video == null || report.path_video == " ")
                  ? $t("checkins.report-video-missing")
                  : $t("checkins.report-video")
              }}
            </CheckinLabel>
            <a
              class="hover:bg-blue-secondary w-full cursor-pointer overflow-hidden rounded-md px-2 py-1 text-center font-semibold text-white transition-all duration-200 hover:px-7 hover:font-bold"
              :class="`${checkListReportStatus(selectedReportIndex, index, 'video') === 'missing' ? 'bg-red-300 pointer-events-none' : ''} ${
                checkListReportStatus(selectedReportIndex, index, 'video') ===
                'not_needed'
                  ? 'opacity-50 bg-gray-500 pointer-events-none'
                  : 'bg-blue-active'
              }`"
              :href="report.path_video"
              target="_blank"
            >
              {{ $t("checkins.report-video") }}
            </a>
          </div>
          <div class="col-span-2 flex h-full w-full flex-col">
            <CheckinLabel>{{ $t("global.status") }}</CheckinLabel>
            <p
              :class="report.status ? 'bg-green-100' : 'bg-red-200'"
              class="border-blue-active w-full rounded-md border-2 p-2 font-bold text-neutral-700"
            >
              {{ report.status ? $t("completed") : $t("pending") }}
            </p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { mapState, mapActions } from "pinia";
import useCheckinsStore from "@/stores/checkins";
import CheckinLabel from "../CheckinLabel.vue";
import CheckinNewTextInput from "../CheckinNewTextInput.vue";
import moment from "moment";
export default {
  name: "CheckListReportsModalContent",
  props: {
    selectedReportIndex: {
      type: Number,
      required: true,
    },
  },
  computed: {
    ...mapState(useCheckinsStore, ["checkinData"]),
  },
  methods: {
    moment: function () {
      return moment();
    },
    checkListReportStatus(item, report, property) {
      if (!this.checkinData?.[0]?.checkListItems?.[0]?.checkin_reports?.length)
        return "error";

      let checkProperty, reportProperty;
      switch (property) {
        case "comment":
          checkProperty = this.checkinData[0].checkListItems[item].comment;
          reportProperty =
            this.checkinData[0].checkListItems[item].checkin_reports[report]
              .text_comment;
          break;
        case "pic":
          checkProperty = this.checkinData[0].checkListItems[item].pic;
          reportProperty =
            this.checkinData[0].checkListItems[item].checkin_reports[report]
              .path_pic;
          break;
        case "video":
          checkProperty = this.checkinData[0].checkListItems[item].video;
          reportProperty =
            this.checkinData[0].checkListItems[item].checkin_reports[report]
              .path_video;
          break;
      }

      let result = "";
      if (checkProperty == 0) result = "not_needed";
      else if (checkProperty == 1) {
        if (reportProperty == null || reportProperty.length < 3)
          result = "missing";
        else if (reportProperty != null && reportProperty.length > 3)
          result = "done";
      }

      // console.log(checkProperty, reportProperty, result, property, item, report);
      return result;
    },
  },
  components: {
    CheckinLabel,
    CheckinNewTextInput,
  },
};
</script>

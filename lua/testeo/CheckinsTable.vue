<template>
  <div class="flex relative flex-col gap-2 max-h-[70dvh] overflow-y-hidden lg:max-h-[73svh]">
    <div
      id="checkin-table-scroll"
      class="lg:max-h-full origin-top scale-y-[95%] lg:relative left-[-11%] lg:scale-100 max-w-[122%] lg:max-w-[100%] lg:left-0 mt-3 overflow-x-auto overflow-y-scroll rounded-lg shadow-md xl:mt-4 table-container"
    >
      <Transition
        enter-from-class="transition-none opacity-0"
        leave-to-class="transition-none opacity-0"
        enter-active-class="transition-opacity duration-100 ease-in-out"
      >
        <table
          v-if="this.isLoading == false && locallyFilteredCheckins.length > 0 && checkins"
          class="z-10 min-w-full table-stripe"
        >
          <thead class="capitalize sticky-top bg-blue-active">
            <tr>
              <template v-for="(header, index) in headers" :key="index">
                <th
                  :class="[
                    !header ? 'hidden' : '',
                    index == 'comms_channel' && collapse ? ['channel-collapse', 'channel'] : '',
                    index == 'comms_channel' && !collapse ? 'channel' : '',
                    index == 'status' && collapse ? ['status-collapse', 'status'] : '',
                    index == 'status' && !collapse ? 'status' : '',
                  ]"
                  class="w-fit text-[12px] lg:text-[16px] font-bold animation-collapse"
                >
                  {{ $t(index.toString()) }}
                </th>
              </template>
              <th class="!py-2 !px-0.5 bg-blue-active text-white sticky">
                <div class="flex items-center justify-center w-full h-full">
                  <ButtonActive
                    class="active:scale-90 hover:bg-blue-secondary/70 !w-[36px] !h-[36px] !p-0 flex justify-center items-center"
                    @click="
                      () => {
                        collapse = !collapse;
                      }
                    "
                  >
                    <font-awesome-icon
                      class="transition duration-300 ease"
                      :class="collapse ? 'rotate-180' : ''"
                      :icon="['fas', 'arrow-right']"
                    />
                  </ButtonActive>
                </div>
              </th>
            </tr>
          </thead>
          <tbody class="bg-white">
            <tr
              v-for="checkin in locallyFilteredCheckins"
              :key="checkin.id"
              class="py-3 text-center text-blue-active hover:bg-blue-secondary hover:bg-opacity-25 text-[12px] lg:text-[14px]"
              :class="{
                'even:bg-gray-300 odd:bg-gray-300/70': checkin['status']['id'] == 4,
                'even:bg-blue-template/50 odd:bg-white': checkin['status']['id'] != 4,
                'table-row-anim': checkin.id == tableRowLoad,
                'text-[#b02626]': checkin.booking?.custom_eta < '12:30',
              }"
            >
              <template v-for="(header, key) in headers">
                <td v-if="key == 'code' && checkin[key]" class="px-3" :class="{ hidden: !headers[key] }">
                  <a :href="'/bookings?page=1&code=' + checkin[key]" target="_blank">
                    <div class="text-[#556AE2] hover:text-[#262d63] underline underline-offset-2">{{ checkin[key] }}</div>
                  </a>
                </td>
                <td v-else-if="key == 'execute_at' && checkin[key]" class="px-3 text-right" :class="{ hidden: !headers[key] }">
                  <div class="flex items-center justify-end w-full space-x-2">
                    <div
                      v-if="checkin.booking?.custom_eta < '12:30'"
                      class="h-6 w-6 bg-[#ED4949] rounded-md cursor-pointer text-white flex justify-center items-center"
                      v-tippy="'Early Check-In'"
                    >
                      <img class="h-4" src="/src/assets/images/early.png" />
                    </div>
                    <div
                      v-if="checkin.execute_at == checkin.last_cleaning.execute_at"
                      class="h-6 w-6 bg-[#9d6f1a] rounded-md cursor-pointer text-white flex justify-center items-center"
                      v-tippy="'Check-Out/In Same Day'"
                    >
                      <img class="h-4" src="/src/assets/images/check-out-in.png" />
                    </div>
                    <div class="w-20">{{ checkin[key] ? checkin[key] : "-/-" }}</div>
                  </div>
                </td>
                <td
                  v-else-if="key == 'checkin_concept' && checkin['checkin_concept']"
                  class="px-3"
                  :class="{ hidden: !headers[key] }"
                >
                  <div class="flex items-center justify-center w-full h-full">
                    <div
                      :class="[
                        checkin[key]['name'] == 'Recepción' ? 'bg-badge-purple' : '',
                        checkin[key]['name'] == 'Transporte' ? 'bg-badge-gray' : '',
                        checkin[key]['name'] == 'Apertura' ? 'bg-badge-orange-bis' : '',
                        checkin[key]['name'] == 'Servicio extra' ? 'bg-badge-purple' : '',
                      ]"
                      class="flex items-center justify-center px-3 py-1 text-white rounded-full w-fit"
                    >
                      {{ checkin[key] ? checkin[key]["name"] : "-/-" }}
                    </div>
                  </div>
                </td>
                <td
                  v-else-if="key == 'last_cleaning' && checkin['last_cleaning']"
                  class="px-3 min-w-[130px] text-right leading-tight"
                  :class="{ hidden: !headers[key] }"
                >
                  <div v-if="checkin[key]['execute_at']">
                    <p>
                      {{ checkin[key] ? checkin[key]["execute_at"] : "-/-" }}
                    </p>
                    <p class="font-bold uppercase text-xd" :class="checkin[key] ? checkin[key]['status'] : ''">
                      {{
                        checkin[key] ? (checkin[key]["status"] == "pre_assigned" ? "Preassigned" : checkin[key]["status"]) : "-/-"
                      }}
                    </p>
                  </div>
                  <div v-else>-/-</div>
                </td>
                <td
                  v-else-if="key == 'last_cleaning_rep' && checkin['last_cleaning_rep']"
                  class="px-3 min-w-[150px]"
                  :class="{ hidden: !headers[key] }"
                >
                  <div class="flex items-center justify-center w-full h-full">
                    <div
                      v-if="checkin[key]['name']"
                      v-tippy="{
                        content:
                          checkin['last_cleaning'] && checkin['last_cleaning']['provider']
                            ? 'Provider: ' + checkin['last_cleaning']['provider']['provider_name']
                            : '-/-',
                      }"
                      :class="[
                        checkin[key]['name'] == 'Pending' ? 'bg-badge-red-bis' : '',
                        checkin[key]['name'] == 'Completed' ? 'bg-completed' : '',
                        checkin[key]['name'] == 'Incidence' ? 'bg-badge-orange-bis' : '',
                        'px-3 !py-1',
                      ]"
                      class="flex items-center justify-center px-3 py-1 text-white rounded-full cursor-pointer w-fit"
                    >
                      {{ checkin[key] ? checkin[key]["name"] : "-/-" }}
                    </div>
                    <div v-else class="text-black">-/-</div>
                  </div>
                </td>
                <td v-else-if="key == 'address' && checkin['address']" class="px-3 text-left" :class="{ hidden: !headers[key] }">
                  <div class="leading-tight w-52">
                    {{ checkin[key] && checkin[key]["key"] ? checkin[key]["key"] : "" }}
                    {{ checkin[key] ? checkin[key]["priority"] : "" }}
                    <span class="text-black">
                      {{ checkin[key] ? checkin[key]["name"] : "-/-" }}
                    </span>
                  </div>
                  <span v-if="checkin[key]['tooltip']" class="tooltip tooltiptext">{{
                    checkin[key] && checkin[key]["tooltip"] != "" ? checkin[key]["tooltip"] : ""
                  }}</span>
                </td>
                <td
                  v-else-if="key == 'staff' && checkin['staff']"
                  class="px-3 max-w-[200px] min-w-[200px]"
                  :class="{ hidden: !headers[key], 'bg-blue-secondary/50': checkin.staff.name == 'Self Check-in' }"
                >
                  <CheckinsNewSelect
                    :options="[
                      {
                        id: null,
                        name: '-/-',
                      },
                      ...staff,
                    ]"
                    :label="'name'"
                    :clearable="false"
                    :appendToBody="true"
                    :placeholder="$t('global.option_short')"
                    v-model="checkin.staff"
                    @update:modelValue="
                      () => {
                        if (checkin.status_id == 3 && checkin.staff.id == null) {
                          showToast(`You can't remove the mintor without changing the status to something than assigned`);
                          checkin.staff = checkin.original_staff;
                        } else {
                          updateCheckin({ ...checkin, user_id: checkin.staff.id });
                        }
                      }
                    "
                  />
                </td>

                <td
                  v-else-if="key == 'reg_state' && checkin['reg_state']"
                  class="px-3"
                  :class="{
                    hidden: !headers[key],
                  }"
                >
                  <div class="flex items-center justify-center w-full h-full">
                    <div
                      :class="[
                        {
                          'bg-badge-red': checkin[key] == 'PENDING',
                          'bg-in-process': checkin[key] == 'SENT',
                          'bg-completed': checkin[key] == 'CORRECT',
                          'bg-red-delete': checkin[key] == 'ERROR',
                        },
                      ]"
                      class="flex items-center justify-center px-3 py-1 text-white rounded-full w-fit"
                    >
                      <font-awesome-icon v-if="checkin[key] == 'ERROR'" :icon="['fas', 'circle-exclamation']" class="mr-1" />{{
                        checkin[key] ? checkin[key] : "-/-"
                      }}
                    </div>
                  </div>
                </td>
                <td v-else-if="key == 'custom_eta'" class="px-3" :class="{ hidden: !headers[key] }">
                  <div class="flex items-center justify-between w-full">
                    <div v-if="checkin.booking?.ms_onboarding" v-tippy="'Complado por el huésped'" class="mr-1.5">
                      <font-awesome-icon :icon="['fas', 'user']" />
                    </div>
                    <InputTime
                      :field_big="true"
                      class=""
                      :field_class_inside="['h-[34px] w-full justify-between text-xs']"
                      v-model:field_value="checkin.booking.custom_eta"
                      :filled="
                        checkin.booking?.custom_eta < '12:30' && checkin.execute_at == checkin.last_cleaning.execute_at
                          ? 'red-500'
                          : ''
                      "
                      v-tippy="
                        checkin.booking?.custom_eta < '12:30' && checkin.execute_at == checkin.last_cleaning.execute_at
                          ? 'Early + Check-Out/In '
                          : ''
                      "
                      @setTimeNull="
                        checkin.booking?.custom_eta != checkin.custom_eta ? updateCheckin({ ...checkin, custom_eta: null }) : ''
                      "
                      @focusout="
                        checkin.booking?.custom_eta != checkin.custom_eta
                          ? updateCheckin({ ...checkin, custom_eta: checkin.booking?.custom_eta })
                          : ''
                      "
                    ></InputTime>
                  </div>
                </td>
                <td v-else-if="key == 'arrivaltime'" class="px-3" :class="{ hidden: !headers[key] }">
                  <InputTime
                    :field_big="true"
                    class=""
                    :field_class_inside="['h-[34px] w-full justify-between text-xs']"
                    v-model:field_value="checkin.booking.arrivaltime"
                    @setTimeNull="
                      checkin.booking?.arrivaltime != checkin.arrivaltime ? updateCheckin({ ...checkin, arrivaltime: null }) : ''
                    "
                    @focusout="
                      checkin.booking?.arrivaltime != checkin.arrivaltime
                        ? updateCheckin({ ...checkin, arrivaltime: checkin.booking?.arrivaltime })
                        : ''
                    "
                  ></InputTime>
                </td>
                <td v-else-if="key == 'transport'" class="px-3 min-w-[150px]" :class="{ hidden: !headers[key] }">
                  <CheckinsNewSelect
                    :small="true"
                    :options="transports"
                    :label="'name'"
                    :appendToBody="true"
                    v-model="checkin.booking.transport"
                    @update:modelValue="updateCheckin({ ...checkin, transport: checkin.booking.transport })"
                    :reduceOnId="true"
                  />
                </td>
                <td v-else-if="key == 'flightnumber'" class="px-3 min-w-[125px] max-w-[150px]" :class="{ hidden: !headers[key] }">
                  <CheckinNewTextInput
                    :small="true"
                    v-model="checkin.booking.flightnumber"
                    @focusout="
                      checkin.booking?.flightnumber != checkin.flightnumber
                        ? updateCheckin({ ...checkin, flightnumber: checkin.booking.flightnumber })
                        : ''
                    "
                  />
                </td>

                <td
                  v-else-if="key == 'report_status' && checkin['report_status']"
                  class="px-3"
                  :class="{ hidden: !headers[key] }"
                >
                  <div class="flex items-center justify-center w-full h-full">
                    <div
                      :class="[
                        checkin[key]['name'] == 'Pending' ? 'bg-badge-red-bis' : '',
                        checkin[key]['name'] == 'Completed' ? 'bg-completed' : '',
                        checkin[key]['name'] == 'Incidence' ? 'bg-badge-orange-bis' : '',
                        'px-3 !py-1',
                      ]"
                      class="flex items-center justify-center px-3 py-1 text-white rounded-full w-fit"
                    >
                      {{ checkin[key] ? checkin[key]["name"] : "-/-" }}
                    </div>
                  </div>
                </td>
                <td v-else-if="key == 'town' && checkin['town']" class="px-3" :class="{ hidden: !headers[key] }">
                  {{ checkin[key] ? checkin[key]["name"] : "-/-" }}
                </td>
                <td v-else-if="key == 'key_status' && checkin.checkin_key?.is_taken != null" class="px-3" :class="{ hidden: !headers[key] }">
                  <span :class="checkin.checkin_key?.is_taken == 1 ? 'text-red-delete' : 'text-completed'">
                    {{ checkin.checkin_key?.is_taken == 1 ? "Staff" : "Office" }}
                  </span>
                </td>
                <td
                  v-else-if="
                    (key == 'bid_1' && checkin['bid_1']) ||
                    (key == 'bid_2' && checkin['bid_2']) ||
                    (key == 'bid_3' && checkin['bid_3']) ||
                    (key == 'bid_4' && checkin['bid_4']) ||
                    (key == 'bid_5' && checkin['bid_5'])
                  "
                  class="px-3"
                  :class="{ hidden: !headers[key] }"
                >
                  {{ checkin[key] && checkin[key]["value"] ? filterBidUser(checkin[key]["value"]) : "-/-" }}
                </td>
                <td
                  v-else-if="key == 'comms_channel' && checkin['comms_channel']"
                  class="px-3 animation-collapse channel"
                  :class="[
                    { hidden: !headers[key] },
                    checkin['status']['id'] == 4 ? '!bg-gray-300' : '',
                    collapse ? 'channel-collapse' : '',
                  ]"
                >
                  <div class="flex h-full">
                    <CheckinsNewSelect
                      :small="true"
                      :style="checkin['booking']['chat'] ? 'max-width: calc(100% - 31px)' : ''"
                      :inlineClass="checkin['booking']['chat'] ? 'no-right-rounded grow' : 'grow'"
                      :colorDictionary="'bookingChannels'"
                      :options="[
                        {
                          value: null,
                          name: checkin[key]['bk_channel'],
                        },
                        ...channels,
                      ]"
                      :appendToBody="true"
                      :clearable="false"
                      :disabled="checkin['status']['id'] == 4"
                      v-model="checkin.booking.communication_channel"
                      :selected="checkin.booking.communication_channel"
                      @update:modelValue="
                        updateCheckin({ ...checkin, communication_channel: checkin.booking.communication_channel })
                      "
                      :reduceOnId="true"
                      :label="'name'"
                    />
                    <a :href="`https://myplazze.com/chats?chat_id=${checkin.booking?.chat?.id}`" target="_blank" class="h-[32px]">
                      <button
                        v-if="checkin['booking']['chat']"
                        v-tippy="'Go to WhatsApp chat 💬'"
                        class="rounded-r-lg border-2 border-[#262d63] border-l-0 px-2 bg-success hover:saturate-200 flex items-center justify-center h-full"
                      >
                        <font-awesome-icon icon="fa-brands fa-whatsapp " class="text-[15px] text-white" />
                      </button>
                    </a>
                  </div>
                </td>
                <td
                  v-else-if="key == 'status' && checkin['status']"
                  class="px-3 animation-collapse status"
                  :class="[
                    { hidden: !headers[key] },
                    checkin['status']['id'] == 4 ? '!bg-gray-300' : '',
                    collapse ? 'status-collapse' : '',
                  ]"
                >
                  <CheckinsNewSelect
                    :options="statuses"
                    :label="'name'"
                    :placeholder="$t('global.option_short')"
                    :colorDictionary="'taskStatuses'"
                    :appendToBody="true"
                    :clearable="false"
                    :small="true"
                    v-model="checkin.status"
                    :selected="checkin.status"
                    @update:modelValue="
                      () => {
                        if ((checkin.status.value == 3 || checkin.status.value == 13) && checkin.booking?.custom_eta == null) {
                          showToast(`You can't select this status because there is no custom ETA defined`);
                          checkin.status = checkin.original_status;
                        } else {
                          updateCheckin({ ...checkin, status_id: checkin.status.value });
                        }
                      }
                    "
                  />
                </td>
                <td v-else class="px-3 min-w-[100px] max-w-[250px]" :class="!headers[key] ? 'hidden' : ''">
                  {{ checkin[key] ? checkin[key] : "-/-" }}
                </td>
              </template>
              <td
                scope="row"
                class="px-0.5 font-medium text-white whitespace-nowrap sticky"
                :class="checkin['status']['id'] == 4 ? '!bg-gray-300' : ''"
              >
                <div class="flex items-center justify-center w-full h-full">
                  <ButtonPrimary
                    class="!w-[36px] !h-[36px] !p-0 flex justify-center items-center"
                    @click="itemView(checkin['id'])"
                  >
                    <font-awesome-icon :icon="['fas', 'eye']" />
                  </ButtonPrimary>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </Transition>
    </div>
    <div
      v-if="this.isLoading == false && locallyFilteredCheckins.length == 0"
      class="flex flex-col items-center justify-center w-full h-64"
    >
      <font-awesome-icon :icon="['fas', 'exclamation-triangle']" class="text-4xl text-blue-active" />
      <p class="text-xl text-center mt-4 w-[70%] text-blue-active" v-html="$t('checkins.no-checkins')"></p>
    </div>

    <div
      @click.prevent="fetchCheckinsWithIncludedQuery((fetchAll = true))"
      v-if="this.isLoading == false && locallyFilteredCheckins.length > 0 && checkins && !isEverythingLoaded"
      class="relative w-full mt-2 -translate-x-1/2 left-1/2 md:left-0 bottom-5 md:bottom-0 md:translate-x-0"
    >
      <div class="flex justify-center">
        <button
          class="h-8 px-5 py-1 font-semibold text-white transition duration-200 rounded-lg md:py-2 md:h-12 bg-blue-active hover:bg-blue-secondary"
        >
          <span v-if="loadingScroll">
            <div class="flex items-center justify-center space-x-2">
              <div class="h-2 w-2 bg-white rounded-full animate-bounce [animation-delay:-0.3s]"></div>
              <div class="h-2 w-2 bg-white rounded-full animate-bounce [animation-delay:-0.15s]"></div>
              <div class="w-2 h-2 bg-white rounded-full animate-bounce"></div>
            </div>
          </span>
          <span v-else>{{ $t("checkins.load-all") }}</span>
        </button>
      </div>
    </div>
    <Transition
      enter-from-class="delay-1000 translate-y-[50%] opacity-0"
      enter-to-class="delay-100"
      leave-to-class="translate-y-[50%] opacity-0"
      enter-active-class="transition duration-300"
      leave-active-class="transition duration-300"
    >
      <div v-show="this.isLoading" class="flex items-center justify-center">
        <font-awesome-icon :icon="['fas', 'spinner']" class="mt-16 animate-spin" size="2xl" />
      </div>
    </Transition>
  </div>

  <!-- <view-checkin-details v-if="checkinDetailsModal" :toggleView="(checkinDetailsModal = true)"></view-checkin-details> -->

  <task-update-loading
    v-if="toggleUpdate"
    :toggleUpdate="toggleUpdate"
    @toggleModalUpdate="toggleUpdate = !toggleUpdate"
  ></task-update-loading>
</template>
<script>
import {
  PaginationFilter,
  TablePagination,
  SmallButtonPrimary,
  InputText,
  InputDropdown,
  BadgeCamaleon,
  ButtonCTA,
  ButtonPrimary,
  ButtonActive,
} from "myplazze-components";
import { mapActions, mapState, mapWritableState } from "pinia";
import ViewCheckinDetails from "./ViewCheckinDetails.vue";
import CommsChannelSelector from "./CommsChannelSelector.vue";
import InputStaffDrop from "./InputStaffDrop.vue";
import TaskUpdateLoading from "./TaskUpdateLoading.vue";
import useCheckinsStore from "@/stores/checkins";
import TaskService from "../../services/TaskService";
import CheckinsNewViewDetails from "./CheckinsNewViewDetails.vue";
import CheckinsNewSelect from "./CheckinsNewSelect.vue";
import InputTime from "./InputTime.vue";
import CheckinNewTextInput from "./CheckinNewTextInput.vue";
import moment from "moment";

import { useRoute, useRouter } from "vue-router";
import { useToast } from "vue-toastification";

export default {
  name: "CheckinsTable",
  inheritAttrs: false,
  components: {
    PaginationFilter,
    TablePagination,
    SmallButtonPrimary,
    InputTime,
    InputText,
    InputDropdown,
    BadgeCamaleon,
    ViewCheckinDetails,
    CommsChannelSelector,
    InputStaffDrop,
    TaskUpdateLoading,
    ButtonCTA,
    ButtonPrimary,
    ButtonActive,
    CheckinsNewViewDetails,
    CheckinsNewSelect,
    CheckinNewTextInput,
  },
  props: {
    headers: { type: [Array, Object], required: true },
  },
  data() {
    return {
      toast: useToast(),
      transports: [
        { name: "airplane", value: "airplane" },
        { name: "train", value: "train" },
        { name: "bus", value: "bus" },
        { name: "car", value: "car" },
        { name: "ship", value: "ship" },
        { name: "alreadyinthecity", value: "alreadyinthecity" },
      ],
      queryString: "",
      toggleViewEdition: false,
      toggleUpdate: false,
      success: false,
      error: false,
      locallyFilteredCheckins: [],
      collapse: false,
      channels: [
        { name: "Whatsapp", value: 1 },
        { name: "No whatsapp", value: 0 },
      ],
      key_status: [
        { value: 10, name: "Office" },
        { value: 11, name: "Staff" },
      ],
    };
  },
  async mounted() {
    const listElm = document.querySelector("#checkin-table-scroll");
    listElm.addEventListener("scroll", e => {
      if (listElm.scrollHeight - listElm.scrollTop - 800 < listElm.clientHeight) {
        if (this.loadingScroll == false && this.pagination.current_page < this.pagination.last_page) {
          this.fetchCheckinsInfiniteScroll();
        }
      }
    });
    listElm.addEventListener("scroll", e => {
      const scroll = listElm.scrollLeft;

      const dropdowns = document.querySelector(".vs__dropdown-menu");
      if (dropdowns) {
        dropdowns.style.display = "none";
        dropdowns.style.visibility = "hidden";
      }
    });

    if (window.innerWidth < 768) {
      this.collapse = true;
    }
  },
  methods: {
    ...mapActions(useCheckinsStore, [
      "fetchCheckins",
      "fetchCheckinsWithIncludedQuery",
      "fetchCheckinsInfiniteScroll",
      "fetchCheckin",
      "updateCheckin",
    ]),
    moment: function (date) {
      return moment(date);
    },
    showToast(text) {
      this.toast.error(text);
    },
    paginationBy(value) {
      let query = [];
      if (value) {
        query.push("pages=" + value);
        query = "?" + query.join("&");
        this.queryString = query.replace("?", "");
      }
      this.fetchCheckins(queryString);
    },
    toggleViewModal() {
      this.checkInSelected = null;
      this.toggleViewEdition = !this.toggleViewEdition;
    },
    itemView(id) {
      this.fetchCheckin(id);
      this.checkinDetailsModal = true;
    },

    filterBidUser(user) {
      const sl_user = this.staff.filter(staff => {
        return staff.id == user;
      })[0];

      if (sl_user) {
        return sl_user.name;
      } else {
        return "-/-";
      }
    },

    updateFilteredList() {
      let shouldShowAll = true;
      for (const key in this.selectedStatistics) {
        if (this.selectedStatistics[key]) {
          shouldShowAll = false;
          break;
        }
      }

      if (shouldShowAll) {
        this.locallyFilteredCheckins = this.checkins;
        return;
      } else {
        this.locallyFilteredCheckins = this.checkins.filter(
          checkin =>
            (checkin.status_id === 1 && this.selectedStatistics.pending) ||
            (checkin.status_id === 2 && this.selectedStatistics.preassigned) ||
            (checkin.status_id === 3 && this.selectedStatistics.assigned) ||
            (checkin.status_id === 4 && this.selectedStatistics.cancelled) ||
            (checkin.status_id === 14 && this.selectedStatistics.available) ||
            (checkin.status_id === 17 && this.selectedStatistics.self) ||
            (checkin.status_id === 19 && this.selectedStatistics.ongoing) ||
            (checkin.status_id === 13 && this.selectedStatistics.completed)
        );
      }
    },
  },
  computed: {
    ...mapWritableState(useCheckinsStore, [
      "checkin",
      "checkins",
      "pagination",
      "staff",
      "statuses",
      "report_statuses",
      "selectedStatistics",
      "loadingScroll",
      "checkinDetailsModal",
      "tableRowLoad",
    ]),
    ...mapState(useCheckinsStore, ["isLoading", "isEverythingLoaded"]),
  },
  watch: {
    selectedStatistics: {
      handler() {
        this.updateFilteredList();
      },
      deep: true,
    },
    checkins: {
      handler() {
        this.updateFilteredList();
      },
    },
  },
};
</script>
<style lang="scss" scoped>
* {
  box-sizing: border-box;
}

.pending {
  color: #ed4949;
}
.pre_assigned {
  color: #ac92ec;
}
.cancelled {
  color: lightgray;
}
.solved {
  color: #e7e769;
}
.incidence {
  color: #f07a13;
}
.assigned {
  color: #86bcff;
}
.ongoing {
  color: #ac92ec;
}
.completed {
  color: #94c120;
}

// .table-container {
//   overflow-y: scroll;
// }

th {
  @apply py-1.5 px-3 bg-blue-active text-white text-center text-[14px];
}

td {
  @apply py-1.5;
}

.animation-collapse {
  transition: right 0.3s ease;
}

td.channel {
  padding-left: 1rem !important;
}

th.sticky {
  min-width: 3.5rem;
  max-width: 3.5rem;
  position: sticky;
  right: 0;
}

th.status {
  min-width: 7.5rem;
  max-width: 7.5rem;
  position: sticky;
  right: 3.5rem;
}

th.channel {
  min-width: 12rem;
  max-width: 12rem;
  position: sticky;
  right: 11rem;

  &:before {
    border-left: 2px solid #fff;
    bottom: 0;
    content: "";
    height: 100%;
    left: 0;
    position: absolute;
  }
}
td.sticky,
th.sticky {
  min-width: 3rem;
  max-width: 3rem;
  position: sticky;
  // background: #fff !important;
  right: 0;
}

td.status,
th.status {
  min-width: 9rem;
  max-width: 9rem;
  position: sticky;
  // background: #fff !important;
  right: 3rem;
}

td.channel-collapse,
th.channel-collapse {
  right: -8.8rem !important;
}

td.status-collapse,
th.status-collapse {
  right: -6rem !important;
}

td.channel,
th.channel {
  min-width: 12rem;
  max-width: 12rem;
  position: sticky;
  // background: #fff !important;
  right: 11.9rem;
}
th.channel {
  &:before {
    border-left: 2px solid #fff;
    bottom: 0;
    content: "";
    height: 100%;
    left: 0;
    position: absolute;
  }
}
td.channel {
  &:before {
    border-left: 2px solid #262d63;
    bottom: 0;
    content: "";
    height: 100%;
    left: 0;
    position: absolute;
  }
}

td.sticky,
td.channel,
td.status {
  background-color: #fff;
  @apply px-1.5 py-1;
  z-index: 1;
}

tr:nth-child(even) td:nth-last-child(-n + 3) {
  background-color: #eceefb;
}

th.sticky,
th.channel,
th.status {
  @apply z-[50];
}

.sticky-top {
  position: sticky;
  top: 0;
  z-index: 10;
}

.table-container::-webkit-scrollbar {
  -webkit-appearance: none;
  @apply hidden md:block md:h-2.5 md:w-2.5;
}

.table-container::-webkit-scrollbar:horizontal {
  @apply bg-tp-transparent rounded-r-md;
}

.table-container::-webkit-scrollbar-thumb {
  @apply bg-blue-cta rounded-md;
}
.tooltip {
  @apply relative inline-block;
}

/* Tooltip text */
.tooltip .tooltiptext {
  @apply w-32 bg-blue-active text-white text-center py-1 rounded-md;
  visibility: hidden;
  position: absolute;
  bottom: 100%;
  left: 80%;
  z-index: -60px;
}

/* Show the tooltip text when you mouse over the tooltip container */
.tooltip:hover .tooltiptext {
  visibility: visible;
}

td {
  font-weight: 700;
}

.table-row-anim {
  background-image: linear-gradient(90deg, transparent 0px, #556ae250 100px, transparent 200px);
  background-color: transparent;
  background-size: 300px;
  animation: shine-lines 1s infinite ease-in-out;
  animation-direction: alternate;
}
@keyframes shine-lines {
  0% {
    background-position: 0%;
  }
  0% {
    background-position: 50%;
    background-color: #556ae220;
  }
  100% {
    background-position: 100%;
  }
}
</style>

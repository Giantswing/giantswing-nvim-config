<template>
   <CheckinsNewModal
      :showIf="showIf"
      :modalTitle="modalTitle"
      @onClose="confirmDeleteModal = false"
   >
      <Transition name="fade">
         <section        key="1"        v-if="          checkinData[0] &&          Object.keys(checkinData[0]).length &&          tableRowLoad == false        "
            <div class="grid gap-3 md:grid-cols-12">
               <!-- Task status -->
               <div class="flex h-full w-full flex-col md:col-span-4">
                  <CheckinLabel>{{ $t("tasks.status") }}</CheckinLabel>

                  <CheckinsNewSelect
                     :options="statuses"
                     :label="'name'"
                     :placeholder="$t('global.option_short')"
                     v-model="checkinData[0].status"
                     :selected="checkinData[0].status"
                     :clearable="false"
                     :colorDictionary="'taskStatuses'"
                  />
               </div>

               <!-- Check-In Staff -->
               <div class="flex h-full w-full flex-col md:col-span-4">
                  <CheckinLabel>Check-In Staff</CheckinLabel>
                  <CheckinsNewSelect
                     :options="staff"
                     :label="'name'"
                     :appendToBody="true"
                     :placeholder="$t('global.option_short')"
                     v-model="checkinData[0].staff"
                  />
               </div>

               <!-- Task concept -->
               <div class="flex h-full w-full flex-col md:col-span-4">
                  <CheckinLabel>{{ $t("checkins.concept") }}</CheckinLabel>
                  <CheckinNewTextInput
                     disabled
                     :value="
                     checkin_concepts.find(
                        (concept) =>
                           concept.value === checkinData[0].checkin_concept_id,
                     ) !== undefined
                        ? checkin_concepts.find(
                           (concept) =>
                              concept.value === checkinData[0].checkin_concept_id,
                        ).name
                        : ''
                     "
                  />
               </div>
               <!-- Time to execute -->
               <div class="h-full w-full md:col-span-3">
                  <CheckinLabel>{{ $t("checkins.timeshift") }}</CheckinLabel>
                  <InputTime
                     :field_big="true"
                     class=""
                     v-model:field_value="checkinData[0].custom_eta"
                     :field_class_inside="[
                        'test w-full justify-between h-max text-xs',
                     ]"
                  ></InputTime>
               </div>

               <!-- Date to execute -->
               <div class="relative md:col-span-3">
                  <CheckinLabel>{{ $t("global.execute") }}</CheckinLabel>
                  <VueDatePicker
                     v-model="checkinData[0].execute_at"
                     :format="'dd/MM/yyyy'"
                     :model-type="'dd-MM-yyyy'"
                     :teleport="true"
                     class="hide-time-input mt-1"
                     input-class-name="border-2 border-blue-active hover:border-blue-secondary text-blue-active rounded-md h-[46px]"
                     menu-class-name="shadow-md rounded-lg"
                     calendar-cell-class-name="rounded-md"
                     auto-apply
                     :enable-time-picker="false"
                     :clearable="false"
                  />
               </div>

               <!-- External links -->
               <div class="flex h-full w-full flex-col md:col-span-6">
                  <CheckinLabel>Links 🔗</CheckinLabel>
                  <div
                     class="flex h-full items-center gap-2 rounded-lg border-2 border-neutral-400 px-2 py-2 md:py-0"
                  >
                     <a
                        class="hover:bg-blue-secondary bg-blue-active w-full cursor-pointer overflow-hidden rounded-md px-2 py-1 text-center text-white transition-all duration-200 hover:px-7 hover:font-bold"
                        :href="`https://guest.mintystay.com/es/${checkinData[0].apartment.iot === 0 ? 'check-in' : 'self-checkin'}/${checkinData[0].code}`"
                        target="_blank"
                     >
                        {{ $t("checkins.form") }}
                     </a>
                     <a
                        class="hover:bg-blue-secondary bg-blue-active w-full cursor-pointer overflow-hidden rounded-md px-2 py-1 text-center text-white transition-all duration-200 hover:px-7 hover:font-bold"
                        :href="`https://guest.mintystay.com/es/self-checkin/${checkinData[0].code}/summary`"
                        target="_blank"
                     >
                        {{ $t("checkins.guests") }}
                     </a>
                     <a
                        class="hover:bg-blue-secondary bg-blue-active w-full cursor-pointer overflow-hidden rounded-md px-2 py-1 text-center text-white transition-all duration-200 hover:px-7 hover:font-bold"
                        :href="`https://guest.mintystay.com/es/my-apartments/${checkinData[0].code}?menu=true`"
                        target="_blank"
                     >
                        Guestbook
                     </a>
                  </div>
               </div>
            </div>

            <!-- SE Checklist reports modal -->
            <Teleport to="body">
               <CheckinsNewModal
                  :showIf="checklistReportsModal"
                  :modalTitle="$t('checkins.checklist-reports')"
                  :isConfirmPopUp="false"
                  :headerColor="'bg-blue-800'"
                  @onClose="checklistReportsModal = false"
               >
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
                              <CheckinLabel>{{
                                 $t("checkins.report-comment")
                                 }}</CheckinLabel>
                              <textarea
                                 disabled
                                 class="border-blue-active h-32 w-full resize-none rounded-md border-2 p-2 disabled:bg-gray-200"
                                 v-model="report.text_comment"
                              />
                           </div>
                           <div class="col-span-2 grid grid-rows-2 gap-2">
                              <div class="col-span-2 flex h-full w-full flex-col">
                                 <CheckinLabel>Links 🔗</CheckinLabel>
                                 <div
                                    class="flex h-full items-center gap-2 rounded-lg border-2 border-neutral-400 px-2 py-2"
                                 >
                                    <a
                                       class="hover:bg-blue-secondary bg-blue-active w-full cursor-pointer overflow-hidden rounded-md px-2 py-1 text-center text-white transition-all duration-200 hover:px-7 hover:font-bold"
                                       :href="report.path_pic"
                                       target="_blank"
                                    >
                                       {{ $t("checkins.report-photo") }}
                                    </a>
                                    <a
                                       class="hover:bg-blue-secondary bg-blue-active w-full cursor-pointer overflow-hidden rounded-md px-2 py-1 text-center text-white transition-all duration-200 hover:px-7 hover:font-bold"
                                       :href="`https://guest.mintystay.com/es/self-checkin/${checkinData[0].code}/summary`"
                                       target="_blank"
                                    >
                                       {{ $t("checkins.report-video") }}
                                    </a>
                                 </div>
                              </div>
                              <div class="col-span-2 flex h-full w-full flex-col">
                                 <CheckinLabel>{{ $t("global.status") }}</CheckinLabel>
                                 <p
                                    class="border-blue-active w-full rounded-md border-2 p-2 font-bold text-neutral-700"
                                 >
                                    {{ report.status ? $t("completed") : $t("pending") }}
                                 </p>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
               </CheckinsNewModal>
            </Teleport>
            <!-- SE Create new checklist item modal --------------------------->
            <CheckinsNewModal
               :showIf="toggleNewCheckList"
               @onClose="toggleNewCheckList = false"
               :modalTitle="$t('checkins.new_checklist_item')"
               :isConfirmPopUp="true"
               :headerColor="'bg-blue-800'"
            >
               <div>
                  <div class="grid grid-cols-5 gap-3">
                     <div class="col-span-4">
                        <CheckinLabel>{{ $t("global.title") }}</CheckinLabel>
                        <CheckinNewTextInput />
                     </div>
                     <div class="col-span-1 flex justify-end gap-4">
                        <div class="flex flex-col">
                           <CheckinLabel>Photo</CheckinLabel>
                           <input
                              type="checkbox"
                              class="border-blue-active h-[38px] w-[38px] rounded-md border-2"
                           />
                        </div>
                        <div class="flex flex-col">
                           <CheckinLabel>Video</CheckinLabel>
                           <input
                              type="checkbox"
                              class="border-blue-active h-[38px] w-[38px] rounded-md border-2"
                           />
                        </div>
                     </div>
                     <div class="col-span-5 mt-5">
                        <button
                           class="hover:bg-blue-secondary w-full rounded-md bg-blue-800 px-8 py-2 font-semibold text-white transition-all duration-200 focus:outline-none"
                        >
                           {{ $t("global.save") }}
                        </button>
                     </div>
                  </div>
                  <div
                     v-if="success"
                     class="bg-success my-1 h-fit w-full rounded-md border-0 p-3 shadow-lg md:col-span-2"
                  >
                     <div class="flex flex-col justify-end gap-3 md:flex-row">
                        {{ $t("checkins.new_item_success") }}
                     </div>
                  </div>
                  <div
                     v-if="error"
                     class="bg-mandatory my-3 h-24 w-full rounded-md p-3 shadow-xl"
                  >
                     {{ $t("global.error") }}
                  </div>
               </div>
            </CheckinsNewModal>
            <!-- SE Confirm delete modal ------------------------------------------------------------->
            <CheckinsNewModal
               :showIf="confirmDeleteModal"
               :modalTitle="$t('checkins.delete_pushes')"
               :isConfirmPopUp="true"
               @onClose="confirmDeleteModal = false"
               :headerColor="'bg-red-800'"
            >
               <div class="h-full py-6">
                  <h2 class="mb-6 text-center text-lg font-semibold">
                     {{ $t("checkins.delete_push_message") }}
                  </h2>
                  <div class="flex items-end justify-center">
                     <button
                        @click.prevent="
                        () => {
                           deleteAllPushes(checkinData[0].id);
                           confirmDeleteModal = false;

                           this.checkinData[0].pushes = [];
                        }
                        "
                        class="group flex cursor-pointer items-center justify-between gap-3 rounded-md border-2 border-red-500 bg-white px-8 py-2 font-semibold text-red-500 transition duration-200 hover:scale-105 hover:bg-red-700 hover:text-white"
                     >
                        <font-awesome-icon
                           :icon="['fas', 'trash']"
                           class="text-red-500 group-hover:text-white"
                           size="md"
                        />
                        {{ $t("global.delete") }}
                     </button>
                  </div>
               </div>
            </CheckinsNewModal>
            <!------------------------------->

            <CheckinsTabDrawer
               :tabSelected="currentTab"
               @onTabSelected="
               (value) => {
                  currentTab = value;
                  $router.push({
                     query: { id: this.checkinData[0].id, tab: this.currentTab },
                  });
               }
               "
               :tabNames="[
                  $t('checkins.tab-checkin'),
                  $t('checkins.tab-pushes'),
                  $t('checkins.tab-guests'),
                  $t('checkins.tab-checklist'),
                  $t('checkins.tab-financial'),
               ]"
            >
               <!------------------------------>

               <!-- Info Check-In -->
               <template v-slot:item-1>
                  <div class="grid gap-3 md:grid-cols-12">
                     <!-- Apartment connected to the task -->
                     <div class="flex h-full w-full flex-col md:col-span-6">
                        <CheckinLabel>{{ $t("global.address") }}</CheckinLabel>
                        <CheckinNewTextInput
                           v-model="checkinData[0].apartment.address"
                           disabled
                        />
                     </div>

                     <!-- Check-In date -->
                     <div class="flex h-full w-full flex-col md:col-span-3">
                        <CheckinLabel>{{ $t("checkins.checkin_date") }}</CheckinLabel>
                        <CheckinNewTextInput
                           v-model="checkinData[0].check_in"
                           disabled
                        />
                     </div>

                     <!-- Check-Out date -->
                     <div class="flex h-full w-full flex-col md:col-span-3">
                        <CheckinLabel>{{ $t("checkins.checkout_date") }}</CheckinLabel>
                        <CheckinNewTextInput
                           v-model="checkinData[0].check_out"
                           disabled
                        />
                     </div>

                     <!-- Access instructions -->
                     <div class="flex h-full w-full flex-col md:col-span-4">
                        <CheckinLabel>{{ $t("apartments.instructions") }}</CheckinLabel>
                        <textarea
                           v-model="checkinData[0].apartment.access_instructions"
                           class="border-blue-active text-blue-active h-20 w-full resize-none rounded-md border-2 p-2 text-sm font-semibold disabled:border-gray-500 disabled:bg-gray-200 disabled:text-gray-500"
                           :placeholder="$t('apartments.instructions')"
                           disabled
                        ></textarea>
                     </div>

                     <!-- Specific task instructions -->
                     <div class="flex h-full w-full flex-col md:col-span-4">
                        <CheckinLabel>{{ $t("checkins.instructions") }}</CheckinLabel>
                        <textarea
                           v-model="checkinData[0].specific_task"
                           class="border-blue-active text-blue-active h-20 w-full resize-none rounded-md border-2 p-2 text-sm font-semibold"
                           :placeholder="$t('checkins.instructions')"
                        ></textarea>
                     </div>

                     <!-- Internal comments -->
                     <div class="flex h-full w-full flex-col md:col-span-4">
                        <CheckinLabel>{{ $t("checkins.internal") }}</CheckinLabel>
                        <textarea
                           v-model="checkinData[0].manager_comment"
                           class="border-blue-active text-blue-active h-20 w-full resize-none rounded-md border-2 bg-yellow-50 p-2 text-sm font-semibold"
                           :placeholder="$t('checkins.internal')"
                        ></textarea>
                     </div>

                     <!-- Key status -->
                     <div class="flex h-full w-full flex-col md:col-span-6">
                        <CheckinLabel>{{ $t("checkins.key_st") }}</CheckinLabel>
                        <CheckinsNewSelect
                           :options="key_status"
                           :label="'name'"
                           :appendToBody="true"
                           :placeholder="$t('global.option_short')"
                           v-model="checkinData[0].apartment.key_status"
                        />
                     </div>

                     <!-- Key Number -->
                     <div class="flex h-full w-full flex-col md:col-span-6">
                        <CheckinLabel>{{ $t("apartments.numkey") }}</CheckinLabel>
                        <CheckinNewTextInput
                           v-model="checkinData[0].apartment.keys"
                           type="number"
                        />
                     </div>
                  </div>
               </template>

               <template v-slot:item-2>
                  <!-- Pujas/Pushes Staff -->
                  <div>
                     <div
                        v-if="checkinData[0].pushes && checkinData[0].pushes.length > 0"
                     >
                        <div
                           class="border-blue-active w-full overflow-hidden rounded-lg border-2"
                        >
                           <table class="w-full">
                              <tr class="bg-blue-active py-2 text-white">
                                 <th>Nº</th>
                                 <th>{{ $t("name") }}</th>
                                 <th>{{ $t("global.date") }}</th>
                              </tr>
                              <tr
                                 v-for="(push, index) in checkinData[0].pushes"
                                 :key="push.id"
                                 class="hover:bg-blue-menu h-10 text-center font-semibold shadow-black transition-all duration-200 odd:bg-white even:bg-neutral-300 hover:text-white hover:shadow-md"
                              >
                                 <td class="border-r-2 border-gray-400">
                                    {{ index + 1 }}
                                 </td>
                                 <td class="border-r-2 border-gray-400">
                                    {{ push.user.full_name }}
                                 </td>
                                 <td>
                                    {{ moment(push.created_at).format("DD/MM/YYYY HH:mm") }}
                                 </td>
                              </tr>
                           </table>
                        </div>
                        <div class="mt-4 flex justify-center">
                           <button
                              @click.prevent="confirmDeleteModal = true"
                              class="group flex cursor-pointer items-center justify-between gap-3 rounded-md border-2 border-red-500 bg-white px-8 py-2 font-semibold text-red-500 transition duration-200 hover:scale-105 hover:bg-red-700 hover:text-white"
                           >
                              <font-awesome-icon
                                 :icon="['fas', 'trash']"
                                 class="text-red-500 group-hover:text-white"
                                 size="md"
                              />
                              {{ $t("checkins.delete_pushes") }}
                           </button>
                        </div>
                     </div>
                     <div
                        v-else
                        class="flex w-full items-center justify-center gap-4 rounded-lg border-2 border-red-500 bg-white p-6"
                     >
                        <font-awesome-icon
                           :icon="['fas', 'exclamation-triangle']"
                           class="inline text-red-500"
                           size="lg"
                        />
                        <p class="text-center font-bold text-red-500">
                           {{ $t("checkins.no-pushes") }}
                        </p>
                     </div>
                  </div>
               </template>

               <template v-slot:item-3>
                  <!-- ID Huéspedes -->
                  <div>
                     <div class="m-4 grid gap-3 md:grid-cols-3">
                        <div
                           class="hover:scale-115 border-blue-active hover:bg-blue-active group flex cursor-pointer items-center justify-between rounded-full border-2 bg-white px-3 py-2 transition duration-150 hover:text-white"
                           v-for="pill in [
                              {
                                 title: $t('apartments.guests'),
                                 value: checkinData[0].booking.adults,
                                 iconPath: 'user',
                              },
                              {
                                 title: $t('checkins.reg_guests'),
                                 value: checkinData[0].contracts.length,
                                 iconPath: 'pen',
                              },
                              {
                                 title: $t('checkins.reg_state'),
                                 value:
                                 checkinData[0].booking.checkin_status != null &&
                                    checkinData[0].booking.checkin_status != 5
                                    ? checkin_statuses.find(
                                       (status) =>
                                          status.value ==
                                             checkinData[0].booking.checkin_status,
                                    ).name
                                    : 'No data',
                                 iconPath: 'rectangle-list',
                              },
                           ]"
                        >
                           <div class="flex w-full items-center">
                              <div
                                 class="border-blue-active hidden border-r-2 border-opacity-50 pl-2 pr-4 group-hover:border-white lg:block"
                              >
                                 <!-- <img :src="pill.iconPath" alt="Person" class="w-5 h-5 group-hover:invert opacity-70" /> -->
                                 <font-awesome-icon
                                    :icon="['fas', pill.iconPath]"
                                    class="text-blue-active h-4 w-4 group-hover:text-white"
                                 />
                              </div>
                              <p
                                 class="text-blue-active pl-3 font-semibold group-hover:text-white"
                              >
                                 {{ pill.title }}
                              </p>
                           </div>
                           <p
                              class="bg-blue-active group-hover:text-blue-active whitespace-nowrap rounded-full px-4 font-semibold text-white transition-all duration-500 group-hover:bg-white group-hover:px-6 group-hover:font-bold"
                           >
                              {{ pill.value }}
                           </p>
                        </div>
                     </div>
                     <!-- Contracts -->
                     <div
                        v-if="
                        checkinData[0].contracts &&
                           checkinData[0].contracts.length > 0
                        "
                        class="border-blue-active w-full overflow-hidden rounded-lg border-2"
                     >
                        <table class="w-full">
                           <tr class="bg-blue-active py-2 text-white">
                              <th>Nº</th>
                              <th>{{ $t("bookings.country") }}</th>
                              <th>{{ $t("name") }}</th>
                              <th>{{ $t("global.status") }}</th>
                           </tr>
                           <tr
                              v-for="(contract, index) in checkinData[0].contracts"
                              :key="contract.id"
                              class="hover:bg-blue-menu h-10 text-center font-semibold shadow-black transition-all duration-200 odd:bg-white even:bg-neutral-300 hover:text-white hover:shadow-md"
                           >
                              <td class="border-r-2 border-gray-400">{{ index + 1 }}</td>
                              <td
                                 class="border-r-2 border-gray-400 first-letter:capitalize"
                              >
                                 {{ contract.country }}
                              </td>
                              <td class="border-r-2 border-gray-400">
                                 {{
                                    contract.firstname + " " + contract.lastname1 + " " + contract.lastname2 
                                 }}
                              </td>
                              <td>
                                 {{
                                 contract_statuses.find(
                                    (status) => status.value === contract.status,
                                 ).name
                                 }}
                              </td>
                           </tr>
                        </table>
                     </div>
                     <div
                        v-else
                        class="flex w-full items-center justify-center gap-4 rounded-lg border-2 border-red-500 bg-white p-6"
                     >
                        <font-awesome-icon
                           :icon="['fas', 'exclamation-triangle']"
                           class="inline text-red-500"
                           size="lg"
                        />
                        <p class="text-center font-bold text-red-500">
                           {{ $t("bookings.no_contracts") }}
                        </p>
                     </div>
                  </div>
               </template>

               <template v-slot:item-4>
                  <!-- SE CheckList -->
                  <div class="h-full">
                     <div
                        v-if="
                        loadingCheckList == false &&
                           checkinData[0].checkListItems &&
                           checkinData[0].checkListItems.length > 0
                        "
                     >
                        <div
                           v-for="(item, index) in checkinData[0].checkListItems"
                           :key="item.id"
                           class="border-blue-active hover:bg-blue-active group relative flex w-full gap-2 rounded-md border-2 bg-white transition duration-200 hover:cursor-pointer hover:text-white hover:shadow-md"
                           @mouseover="showCheckListHover = true"
                           @mouseleave="showCheckListHover = false"
                           @click="
                           () => {
                              selectedReportIndex = index;
                              checklistReportsModal = true;
                           }
                           "
                        >
                           <div
                              class="from-blue-active via-blue-active absolute flex h-full w-[80%] items-center justify-center bg-gradient-to-r from-70% to-transparent transition-all duration-200"
                              :class="`${showCheckListHover ? 'opacity-90' : 'opacity-0'}`"
                           >
                              <p
                                 :class="`${showCheckListHover ? 'mr-0' : 'mr-[30%]'}`"
                                 class="text-lg font-bold text-white transition-all duration-500 ease-in-out"
                              >
                                 {{
                                 item.checkin_reports && item.checkin_reports.length > 0
                                    ? $t("checkins.show-checklist-reports")
                                    : $t("checkins.show-no-checklist-reports")
                                 }}
                              </p>
                           </div>
                           <div class="py-4 pl-4">
                              <p
                                 class="border-blue-active border-r-2 border-opacity-70 pr-4 font-semibold leading-tight text-neutral-800 group-hover:border-white group-hover:text-white"
                              >
                                 {{ item.name }}
                              </p>
                           </div>
                           <div class="flex items-center justify-around gap-2 px-4 pl-2">
                              <div
                                 class="h-8 w-8"
                                 v-for="report in [
                                    {
                                       icon: 'image',
                                       condition: item.pic,
                                       conditionCompleted:
                                       item.pic &&
                                          item.checkin_reports[0] &&
                                          item.checkin_reports[0].path_pic != ' ' &&
                                          item.checkin_reports[0].path_pic != null
                                          ? item.checkin_reports[0].path_pic
                                          : null,
                                    },
                                    {
                                       icon: 'video',
                                       condition: item.video,
                                       conditionCompleted:
                                       item.video &&
                                          item.checkin_reports[0] &&
                                          item.checkin_reports[0].path_video != ' ' &&
                                          item_checkin_reports[0].path_pic != null
                                          ? item.checkin_reports[0].path_video
                                          : null,
                                    },
                                    {
                                       icon: 'comment',
                                       condition: item.comment,
                                       conditionCompleted:
                                       item.comment &&
                                          item.checkin_reports[0] &&
                                          item.checkin_reports[0].text_comment.length > 0
                                          ? item.checkin_reports[0].text_comment
                                          : null,
                                    },
                                 ]"
                              >
                                 <button
                                    class="flex h-full w-full items-center justify-center rounded-md"
                                 >
                                    <font-awesome-icon
                                       :icon="['fas', report.icon]"
                                       class="transition-all duration-200 hover:scale-110 hover:cursor-pointer hover:brightness-150"
                                       :class="`p-2 rounded-lg ${report.condition && !report.conditionCompleted ? 'bg-blue-600 text-white' : 'bg-gray-400 text-gray-500'} ${report.conditionCompleted ? 'bg-green-700 text-white' : ''}`"
                                    />
                                 </button>
                              </div>
                           </div>
                        </div>
                     </div>
                     <div v-else-if="loadingCheckList == true">
                        <div
                           class="flex h-full w-full items-center justify-center py-4"
                        >
                           <font-awesome-icon
                              :icon="['fas', 'spinner']"
                              class="text-blue-active animate-spin"
                              size="xl"
                              spin
                           />
                        </div>
                     </div>
                     <div
                        v-else
                        class="flex w-full items-center justify-center gap-4 rounded-lg border-2 border-red-500 bg-white p-6"
                     >
                        <font-awesome-icon
                           :icon="['fas', 'exclamation-triangle']"
                           class="inline text-red-500"
                           size="lg"
                        />
                        <p class="text-center font-bold text-red-500">
                           {{ $t("checkins.no_checklist_items") }}
                        </p>
                     </div>
                     <div
                        v-if="
                        checkinData[0].status_id != 4 &&
                           checkinData[0].status_id != 13
                        "
                        class="mt-4 flex w-full justify-center px-5"
                     >
                        <button
                           class="bg-blue-active hover:bg-blue-secondary rounded-md px-9 py-3 font-semibold text-white transition-all duration-300 hover:px-12 focus:outline-none"
                           @click="toggleNewCheckList = true"
                        >
                           <font-awesome-icon
                              :icon="['fas', 'plus']"
                              class="pr-2 text-white"
                              size="md"
                           />
                           {{ $t("checkins.new_item") }}
                        </button>
                     </div>
                  </div>
               </template>

               <template v-slot:item-5>
                  <!-- Financiero -->
                  <div class="grid w-full gap-4 md:grid-cols-5">
                     <div class="flex h-full w-full flex-col md:col-span-2">
                        <CheckinLabel> {{ $t("is_double_cost") }}</CheckinLabel>
                        <CheckinMultiToggle
                           :options="['global.no', 'global.yes']"
                           :currentValue="checkinData[0].is_double_cost"
                           @onToggle="(index) => (checkinData[0].is_double_cost = index)"
                        />
                     </div>
                     <div class="flex h-full w-full flex-col md:col-span-3">
                        <CheckinLabel>{{ $t("checkin_cost") }}</CheckinLabel>
                        <div class="flex items-center gap-2">
                           <CheckinNewTextInput
                              :disabled="
                              checkinData[0].is_double_cost === 0 ||
                                 checkinData[0].double_cost === null
                                 ? true
                                 : false
                              "
                              v-model="checkinData[0].double_cost"
                              type="number"
                           />
                           <span class="pr-2 text-lg font-semibold text-neutral-700"
                           >€</span
                           >
                        </div>
                     </div>
                  </div>
               </template>
            </CheckinsTabDrawer>

            <!-- Buttons to save and discard changes -->
            <div
               class="ml-auto mr-0 mt-8 h-full w-full text-right md:col-span-6 md:w-1/2"
            >
               <div class="flex w-full gap-4">
                  <button
                     @click.prevent="$emit('onClose')"
                     class="w-full rounded-md border-2 border-neutral-400 px-8 py-2 font-semibold text-neutral-700 transition duration-200 hover:opacity-70 focus:outline-none"
                  >
                     {{ $t("global.discard") }}
                  </button>
                  <button
                     @click="
                     () => {
                        updateCheckin({
                           ...checkinData[0],
                           status_id: checkinData[0].status.value,
                           user_id:
                           checkinData[0].staff != null
                              ? checkinData[0].staff.id
                              : null,
                           custom_eta: checkinData[0].custom_eta,
                           key_status:
                           checkinData[0].apartment.key_status != null
                              ? checkinData[0].apartment.key_status.value
                              : null,
                           keys: checkinData[0].apartment.keys,
                           specific_task: checkinData[0].specific_task,
                           manager_comment: checkinData[0].manager_comment,
                           execute_at: checkinData[0].execute_at,
                           is_double_cost: checkinData[0].is_double_cost,
                        });

                        this.checkinCopy = JSON.parse(
                           JSON.stringify(this.checkinData[0]),
                        );
                     }
                     "
                     class="bg-blue-active hover:bg-blue-secondary w-full rounded-md px-8 py-2 font-semibold text-white transition-all duration-200 focus:outline-none"
                     :class="this.hasAnyDataChanged == true ? ' saturate-200' : ''"
                  >
                     {{ $t("global.save") }}
                  </button>
               </div>
            </div>
         </section>
         <div key="2" v-else class="slide-motion absolute">
            <div class="flex h-full animate-pulse items-center justify-center">
               <font-awesome-icon
                  :icon="['fas', 'spinner']"
                  class="animate-spin"
                  size="2xl"
               />
            </div>
         </div>
      </Transition>
   </CheckinsNewModal>
</template>
<script>
import CheckinsNewModal from "./CheckinsNewModal.vue";
import { mapState, mapActions } from "pinia";
import useCheckinsStore from "@/stores/checkins";
import CheckinLabel from "./CheckinLabel.vue";
import CheckinsNewSelect from "./CheckinsNewSelect.vue";
import CheckinNewTextInput from "./CheckinNewTextInput.vue";
import { InputTime, ButtonCTA } from "myplazze-components";
import CheckinsTabDrawer from "./CheckinsTabDrawer.vue";
import CheckinDuoToggle from "./CheckinDuoToggle.vue";
import CheckinMultiToggle from "./CheckinMultiToggle.vue";
import CheckinListItem from "./CheckinListItem.vue";
import NewCheckListItem from "./NewCheckListItem.vue";
import moment from "moment";
import CheckinService from "../../services/CheckinService";
import { useRouter, useRoute } from "vue-router";

export default {
   name: "CheckinsNewViewDetails",
   data() {
      return {
         // updatedCheckinData: {},
         key_status: [
            { value: 10, name: "Office" },
            { value: 11, name: "Staff" },
         ],
         checkin_statuses: [
            { value: 1, name: "Sent" },
            { value: 2, name: "Correct" },
            { value: 3, name: "Error" },
            { value: 4, name: "Pending" },
         ],
         contract_statuses: [
            { value: 1, name: "Pending" },
            { value: 2, name: "Completed" },
            { value: 3, name: "Error" },
            { value: 4, name: "Sent" },
         ],
         checkin_concepts: [
            { value: 1, name: "Recepción" },
            { value: 2, name: "Transporte" },
            { value: 3, name: "Apertura" },
            { value: 4, name: "Servicio extra" },
         ],
         confirmDeleteModal: false,
         selectedReportIndex: null,
         checklistReportsModal: false,
         toggleNewCheckList: false,
         currentTab: 1,
         checkinCopy: {},
         initialLoad: true,
         dataChanged: false,
         showCheckListHover: false,
      };
   },
   components: {
      CheckinLabel,
      CheckinListItem,
      CheckinMultiToggle,
      CheckinNewTextInput,
      CheckinsNewModal,
      CheckinsNewSelect,
      CheckinsTabDrawer,
      InputTime,
      NewCheckListItem,
   },
   props: {
      showIf: {
         type: Boolean,
         required: true,
      },
      modalTitle: {
         type: String,
         required: true,
      },
   },
   computed: {
      ...mapState(useCheckinsStore, [
         "checkList",
         "checkinData",
         "loadingCheckList",
         "staff",
         "statuses",
         "tableRowLoad",
      ]),
      hasAnyDataChanged: function () {
         // Use deepEqual for deep object comparison
         const isDataChanged = !deepEqual(this.checkinData[0], this.checkinCopy);

         return isDataChanged;
      },
   },
   setup() {
      const router = useRouter();
      const route = useRoute();
   },
   methods: {
      ...mapActions(useCheckinsStore, [
         "fetchCheckList",
         "deleteAllPushes",
         "updateCheckin",
      ]),
      moment: function () {
         return moment();
      },
      async getCheckinCost() {
         // if (this.checkinData[0].is_double_cost) {
         let query = `?billable=${this.checkinData[0].is_double_cost}&task_id=${this.checkinData[0].id}`;
         const response = await CheckinService.getCheckinCost(query);
         if (response.success && response.data.cost) {
            this.checkinData[0].double_cost = response.data.cost;
         }
         // }
      },
   },

   // This is to perform some operations when checkinData is first loaded
   watch: {
      checkinData: {
         handler() {
            // If there is no data yet, return
            if (!this.checkinData || Object.keys(this.checkinData).length === 0) {
               this.initialLoad = true;
               return;
            }

            if (this.initialLoad == true) {
               this.checklistReportsModal = false;
               this.toggleNewCheckList = false;
               // This reconstructs the key_status object from the value so that the select component can display the correct value
               if (this.checkinData[0].apartment.key_status != null)
               this.checkinData[0].apartment.key_status = this.key_status.find(
                  (status) =>
                     status.value == this.checkinData[0].apartment.key_status,
               );

               this.getCheckinCost();

               this.currentTab = this.$route.query.tab ? this.$route.query.tab : 1;
               if (this.checkinData[0].id != null) {
                  this.$router.push({
                     query: { id: this.checkinData[0].id, tab: this.currentTab },
                  });
               }

               this.checkinCopy = JSON.parse(JSON.stringify(this.checkinData[0]));
            }

            this.initialLoad = false;
         },
      },
      showIf: {
         handler() {
            if (this.showIf == false) {
               this.initialLoad = true;
            }
         },
      },
   },
};

function deepEqual(obj1, obj2) {
   // Check if both objects are not null
   if (obj1 === null || obj2 === null) {
      return obj1 === obj2; // Use simple equality for null values
   }
   // Check if both objects are of type object
   if (typeof obj1 !== "object" || typeof obj2 !== "object") {
      return obj1 === obj2; // Use simple equality for non-objects
   }

   // Check if the number of keys is the same
   const keys1 = Object.keys(obj1);
   const keys2 = Object.keys(obj2);
   if (keys1.length !== keys2.length) {
      return false;
   }

   // Check if each key and its corresponding value are equal recursively
   for (const key of keys1) {
      if (!deepEqual(obj1[key], obj2[key])) {
         return false;
      }
   }

   return true; // Objects are deeply equal
}
</script>

<style>
.fade-enter-active,
.fade-leave-active {
   transition: opacity 0.15s;
}

.fade-enter,
.fade-leave-to {
   opacity: 0;
}

@keyframes gradient {
0% {
   background-position: 0% 50%;
}

50% {
   background-position: 100% 50%;
}

100% {
   background-position: 0% 50%;
}
}

@keyframes slide {
0% {
   transform: translateX(-100%);
}

100% {
   transform: translateX(100%);
}
}

.slide-motion {
   @apply absolute inset-0;
   animation: slide 1s infinite;
   background: linear-gradient(90deg, #f0f0f0 25%, #d5d5d5 50%, #f0f0f0 75%);
   background-size: 400% 400%;
   animation: gradient 1.5s infinite;
}
</style>

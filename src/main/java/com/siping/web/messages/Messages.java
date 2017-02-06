package com.siping.web.messages;

import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.MessageSource;

import org.springframework.web.servlet.i18n.SessionLocaleResolver;
import org.springframework.web.util.WebUtils;

public class Messages {
    private static MessageSource messageSource;

    public MessageSource getMessageSource() {
        return Messages.messageSource;
    }

    public void setMessageSource(MessageSource messageSource) {
        Messages.messageSource = messageSource;
    }

    /**
     * get Error Message
     * @param operation
     * @param result
     * @param request
     * @return
     */
    @SuppressWarnings("rawtypes")
    public static String getErrorMessage(String operation, Map result, HttpServletRequest request) {
        String errorMsg = getMessage(request, "hrms.applyFailure.unknownError");
        int errorCode = ((Integer) result.get("errcode")).intValue();
        try {
            if (operation.equalsIgnoreCase("OtApply")) {
                if (errorCode == 0) {
                    errorMsg = getMessage(request, "hrms.applySuccess.waitingApproval");
                } else if (errorCode == 1) {
                    errorMsg = getMessage(request, "hrms.applyFailure.tiemFormatError");
                } else if (errorCode == 2) {
                    errorMsg = getMessage(request, "hrms.applyFailure.endTimeBeforeStartedTime");
                } else if (errorCode == 3) {
                    errorMsg = getMessage(request, "hrms.applyFailure.sameOTTimeAndShiftTime");
                } else if (errorCode == 4) {
                    errorMsg = getMessage(request, "hrms.applyFailure.sameOTTime");
                } else if (errorCode == 5) {
                    errorMsg = getMessage(request, "hrms.applyFailure.sameOTTimeAndLeaveTime");
                } else if (errorCode == 6) {
                    errorMsg = getMessage(request, "hrms.applyFailure.sameOTTimeAndOnDutyTime");
                } else if (errorCode == 7) {
                    errorMsg = "申请失败:只能申请当日之后的加班";
                } else if (errorCode == 8) {
                    errorMsg = "申请失败:只能申请 " + (String) result.get("appDaysAfter") + " 天以内的加班";
                } else if (errorCode == 9) {
                    errorMsg = getMessage(request, "hrms.applyFailure.overtimeTypeAndDifferentWorkingShift");
                } else if (errorCode == 10) {
                    errorMsg = getMessage(request, "hrms.applyFailure.addApprover");
                } else if (errorCode == 11) {
                    errorMsg = "申请失败:员工 [" + (String) result.get("erremp") + "] 本月加班超过 [" + (String) result.get("maxothour") + "] 小时";
                } else if (errorCode == 12) {
                    errorMsg = "申请失败:紧急加班不可以申请 " + (String) result.get("applydaysbefore") + " 天前之后的加班";
                } else if (errorCode == 13) {
                    errorMsg = "申请失败:员工 [" + (String) result.get("erremp") + "] 本月加班未满 [" + (String) result.get("maxothour") + "] 小时";
                } else if (errorCode == 14) {
                    errorMsg = "申请失败:员工 [" + (String) result.get("erremp") + "] 不能在这一天申请节日特勤加班,原因：只有倒班人员在休息日才能申请！";
                } else if (errorCode == 16) {
                    errorMsg = getMessage(request, "hrms.applyFailure.holidayOTOnholiday");
                } else if (errorCode == 17) {
                    errorMsg = getMessage(request, "hrms.applyFailure.noApprover");
                } else if (errorCode == 18) {
                    errorMsg = getMessage(request, "hrms.applyFailure.sameOTTimeAndEduTime");
                } else if (errorCode == 19) {
                    errorMsg = "您没有对您选择的加班类型进行参数设置，请先设置！";
                } else if (errorCode == 20) {
                    errorMsg = "您申请的加班类型在参数设置中重复，请重新检查设置！";
                } else if (errorCode == 21) {
                    errorMsg = getMessage(request, "hrms.applyFailure.sameOTTimeAndBTTime");
                } else if (errorCode == 31) {
                    errorMsg = "申请失败:员工 [" + (String) result.get("erremp") + "] 选择加班班次和申请时间冲突！";
                } else if (errorCode == 90) {
                    errorMsg = getMessage(request, "hrms.applyFailure.detailLocked");
                    errorMsg = errorMsg.replace("Day", "[ " + (String) result.get("errDate") + "]");
                } else {
                    errorMsg = getMessage(request, "hrms.applyFailure.unknownError");
                }
            } else if (operation.equalsIgnoreCase("LeaveApply")) {
                if (errorCode == 0) {
                    errorMsg = getMessage(request, "hrms.applySuccess.waitingApproval");
                } else if (errorCode == 1) {
                    errorMsg = getMessage(request, "hrms.applyFailure.tiemFormatError");
                } else if (errorCode == 2) {
                    errorMsg = getMessage(request, "hrms.applyFailure.endTimeBeforeStartedTime");
                } else if (errorCode == 3) {
                    errorMsg = getMessage(request, "hrms.applyFailure.noEnoughAnnualLeave");
                    errorMsg = errorMsg.replace("ID", "[ " + (String) result.get("erremp") + "]");
                } else if (errorCode == 4) {
                    errorMsg = getMessage(request, "hrms.applyFailure.sameLeaveTimeAndOTTime");
                } else if (errorCode == 5) {
                    errorMsg = getMessage(request, "hrms.applyFailure.sameLeaveTime");
                } else if (errorCode == 6) {
                    errorMsg = getMessage(request, "hrms.applyFailure.sameLeaveTimeAndOnDutyTime");
                } else if (errorCode == 10) {
                    errorMsg = getMessage(request, "hrms.applyFailure.addApprover");
                } else if (errorCode == 11) {
                    errorMsg = "申请失败:员工[" + (String) result.get("erremp") + "]历史假期数不足";
                } else if (errorCode == 12) {
                    errorMsg = "申请失败:员工[" + (String) result.get("erremp") + "]特殊事假不得少于五天";
                } else if (errorCode == 13) {
                    errorMsg = getMessage(request, "hrms.applyFailure.Leave13");
                } else if (errorCode == 14) {
                    errorMsg = getMessage(request, "hrms.applyFailure.noApprover");
                } else if (errorCode == 15) {
                    errorMsg = getMessage(request, "hrms.applyFailure.useAnnualLeaveFirst");
                } else if (errorCode == 16) {
                    errorMsg = getMessage(request, "hrms.applyFailure.noEnoughOTRest");
                } else if (errorCode == 90) {
                    errorMsg = getMessage(request, "hrms.applyFailure.detailLocked");
                    errorMsg = errorMsg.replace("Day", "[ " + (String) result.get("errDate") + "]");
                } else if (errorCode == 17) {
                    errorMsg = getMessage(request, "hrms.applyFailure.attachmentType");
                } else if (errorCode == 19) {
                    errorMsg = getMessage(request, "hrms.applyFailure.noLeaveTypeParameter");
                } else if (errorCode == 20) {
                    errorMsg = getMessage(request, "hrms.applyFailure.sameLeaveTypeParameter");
                } else if (errorCode == 21) {
                    errorMsg = getMessage(request, "hrms.applyFailure.annualLeaveGreaterThan4");
                } else if (errorCode == 22) {
                    errorMsg = getMessage(request, "hrms.applyFailure.sickLeaveOverToplimit");
                } else if (errorCode == 23) {
                    errorMsg = getMessage(request, "hrms.applyFailure.privateAffairLeaveOverToplimit");
                } else if (errorCode == 31) {
                    errorMsg = (String) result.get("errmsg");
                } else if (errorCode == 32) {
                    errorMsg = (String) result.get("errmsg");
                } else {
                    errorMsg = getMessage(request, "hrms.applyFailure.unknownError");
                }
            } else if (operation.equalsIgnoreCase("BTApply")) {
                if (errorCode == 0) {
                    errorMsg = getMessage(request, "hrms.applySuccess.waitingApproval");
                } else if (errorCode == 1) {
                    errorMsg = getMessage(request, "hrms.applyFailure.tiemFormatError");
                } else if (errorCode == 2) {
                    errorMsg = getMessage(request, "hrms.applyFailure.endTimeBeforeStartedTime");
                } else if (errorCode == 4) {
                    errorMsg = getMessage(request, "hrms.applyFailure.sameLeaveTimeAndOTTime");
                } else if (errorCode == 5) {
                    errorMsg = getMessage(request, "hrms.applyFailure.sameBTTime");
                } else if (errorCode == 17) {
                    errorMsg = getMessage(request, "hrms.applyFailure.noApprover");
                } else {
                    errorMsg = getMessage(request, "hrms.applyFailure.unknownError");
                }
            } else if (operation.equalsIgnoreCase("whApply")) {
                if (errorCode == 0) {
                    errorMsg = getMessage(request, "hrms.applySuccess.waitingApproval");
                } else if (errorCode == -5) {
                    errorMsg = getMessage(request, "hrms.applyFailure.whTotalOrDateNot");
                } else if (errorCode == 17) {
                    errorMsg = getMessage(request, "hrms.applyFailure.noApprover");
                } else {
                    errorMsg = getMessage(request, "hrms.applyFailure.unknownError");
                }
            } else if (operation.equalsIgnoreCase("ExpApply")) {
                if (errorCode == 0) {
                    errorMsg = getMessage(request, "hrms.applySuccess.waitingApproval");
                } else if (errorCode == 1) {
                    errorMsg = getMessage(request, "hrms.applyFailure.tiemFormatError");
                } else if (errorCode == 2) {
                    errorMsg = getMessage(request, "hrms.applyFailure.endTimeBeforeStartedTime");
                } else if (errorCode == 4) {
                    errorMsg = getMessage(request, "hrms.applyFailure.sameLeaveTimeAndOTTime");
                } else if (errorCode == 5) {
                    errorMsg = getMessage(request, "hrms.applyFailure.sameExpApp");
                } else if (errorCode == 17) {
                    errorMsg = getMessage(request, "hrms.applyFailure.noApprover");
                } else {
                    errorMsg = getMessage(request, "hrms.applyFailure.unknownError");
                }
            } else if (operation.equalsIgnoreCase("cardApply")) {
                if (errorCode == 0)
                    errorMsg = getMessage(request, "hrms.applySuccess.waitingApproval");
                else if (errorCode == 1)
                    errorMsg = getMessage(request, "hrms.applyFailure.addApprover");
                else if (errorCode == 90) {
                    errorMsg = getMessage(request, "hrms.applyFailure.detailLocked");
                    errorMsg = errorMsg.replace("Day", "[ " + (String) result.get("errDate") + "]");
                } else if (errorCode == -1) {
                    errorMsg = getMessage(request, "hrms.applyFailure.Repeat.Application");
                }
            } else if (operation.equalsIgnoreCase("matchApply")) {
                if (errorCode == 0) {
                    errorMsg = getMessage(request, "hrms.applySuccess.waitingApproval");
                } else if (errorCode == 1) {
                    errorMsg = getMessage(request, "hrms.applyFailure.tiemFormatError");
                } else if (errorCode == 2) {
                    errorMsg = getMessage(request, "hrms.applyFailure.endTimeBeforeStartedTime");
                } else if (errorCode == 4) {
                    errorMsg = getMessage(request, "hrms.applyFailure.sameOnDutyTimeAndOTTime");
                } else if (errorCode == 5) {
                    errorMsg = getMessage(request, "hrms.applyFailure.sameOnDutyTimeAndLeaveTime");
                } else if (errorCode == 6) {
                    errorMsg = getMessage(request, "hrms.applyFailure.sameOnDutyTime");
                } else if (errorCode == 10) {
                    errorMsg = getMessage(request, "hrms.applyFailure.addApprover");
                } else if (errorCode == 90) {
                    errorMsg = getMessage(request, "hrms.applyFailure.detailLocked");
                    errorMsg = errorMsg.replace("Day", "[ " + (String) result.get("errDate") + "]");
                } else {
                    errorMsg = getMessage(request, "hrms.applyFailure.unknownError");
                }
            } else if (operation.equalsIgnoreCase("HandselApply")) {
                if (errorCode == 0) {
                    errorMsg = getMessage(request, "hrms.applySuccess.waitingApproval");
                } else if (errorCode == 1) {
                    errorMsg = getMessage(request, "hrms.applyFailure.addApprover");
                } else if (errorCode == 2) {
                    errorMsg = getMessage(request, "hrms.applyFailure.noApprover");
                } else if (errorCode == 15) {
                    errorMsg = "申请失败:没有操作此员工的权限";
                } else {
                    errorMsg = getMessage(request, "hrms.applyFailure.unknownError");
                }
            } else if (operation.equalsIgnoreCase("etnApply")) {
                if (errorCode == 0) {
                    errorMsg = getMessage(request, "hrms.applySuccess.waitingApproval");
                } else if (errorCode == 1) {
                    errorMsg = getMessage(request, "hrms.applyFailure.addApprover");
                } else if (errorCode == 2) {
                    errorMsg = getMessage(request, "hrms.sameDataAlreadyExists");
                } else {
                    errorMsg = getMessage(request, "hrms.applyFailure.unknownError");
                }
            } else if (operation.equalsIgnoreCase("perInfoApp")) {
                if (errorCode == 0) {
                    errorMsg = getMessage(request, "hrms.applySuccess.waitingApproval");
                } else if (errorCode == 1) {
                    errorMsg = getMessage(request, "hrms.applyFailure.addApprover");
                } else if (errorCode == 2) {
                    errorMsg = getMessage(request, "hrms.sameDataAlreadyExists");
                } else if (errorCode == 3) {
                    errorMsg = getMessage(request, "hrms.sameIdCardNoAlreadyExists");
                } else if (errorCode == 4) {
                    errorMsg = getMessage(request, "hrms.editData");
                } else {
                    errorMsg = getMessage(request, "hrms.applyFailure.unknownError");
                }
            } else if (operation.equalsIgnoreCase("ToolApply")) {
                if (errorCode == 0) {
                    errorMsg = "申请成功，等待确认！";
                } else if (errorCode == 1) {
                    errorMsg = "申请时间内物品已被别人借走";
                } else if (errorCode == -1) {
                    errorMsg = "出现错误！！";
                } else {
                    errorMsg = "出现未知错误！！";
                }
            } else {
                errorMsg = getMessage(request, "hrms.applyFailure.unknownError");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return errorMsg;
    }
    public static String getMessage(HttpServletRequest request, String str) {
        Locale locale = (Locale) WebUtils.getSessionAttribute(request, SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME);
        return messageSource.getMessage(str, null, locale);
    }

    public static String getLanguage(HttpServletRequest request) {
        Locale locale = (Locale) WebUtils.getSessionAttribute(request, SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME);
        if (locale == null) {
            locale = request.getLocale();
        }
        return locale.getLanguage();
    }

    public static Locale getLocale(HttpServletRequest request) {
        Locale locale = (Locale) WebUtils.getSessionAttribute(request, SessionLocaleResolver.LOCALE_SESSION_ATTRIBUTE_NAME);
        return locale == null ? request.getLocale() : locale;
    }
}

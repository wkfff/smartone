package com.siping.ess.service;

public interface ChangeAffirmSer {
	/**
	 * 更改审核状态：同意
	 * @param request
	 * @return
	 */
	public String changeAffirm_flag_agree(String processInstanceId);
	/**
	 * 更改审核状态：否决
	 * @param request
	 * @return
	 */
	public String changeAffirm_flag_veto(String processInstanceId);
}

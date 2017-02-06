package com.siping.doc.bean;

import com.siping.process.bean.ProcessRunning;

/**
 * 业务数据，通常伴随状态更改，会结合审批流程处理
 * @author Mx
 */
public class BusinessData extends MasterData {

    public static final String KEY_FORM = "mainData";

    transient protected ProcessRunning processRunning;

    public ProcessRunning getProcessRunning() {
        return processRunning;
    }

    public void setProcessRunning(ProcessRunning running) {
        this.processRunning = running;
    }

    public ProcessRunning createEmptyProcessRunning() throws Exception {
        if (this.getNo() == null) {
            throw new Exception("Data has No identical Number Info!");
        }

        ProcessRunning initRunning;
        if (processRunning == null) {
            initRunning = new ProcessRunning();
        } else {
            initRunning = this.processRunning;
        }
        initRunning.setDataNo(this.getNo());
        initRunning.setMetaData(this.getMetaData());
        initRunning.setDataClass(this.getClass().getName());
        return initRunning;
    }

}

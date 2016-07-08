package cn.ac.ict.dao;

import java.util.Date;


public class GANGLIA_DAO {

	String UUID;
	String IPADDR;// Host ip address
	String HOSTNAME;// Host name
	String MACHINE_TYPE; // System architecture
	String OS_RELEASE;// Operating system release date

	String CPU_USER;// Percentage of CPU utilization that occurred while
	// executing at the user level [%]
	String CPU_SYSTEM;// Percentage of CPU utilization that occurred while
	// executing at the system level [%]
	String CPU_WIO;// Percentage of time that the CPU or CPUs were idle during
	// which the system had an outstanding disk I/O request
	String CPU_NUM;// Total number of CPUs
	String CPU_SPEED;// CPU Speed in terms of MHz
	String CPU_IDLE;// Percentage of time that the CPU or CPUs were idle and the
	// system did not have an outstanding disk I/O request [%]
	String CPU_NICE;// Percentage of CPU utilization that occurred while
	// executing at the user level with nice priority [%]

	String MEM_TOTAL;// Total amount of memory displayed in KBs
	String MEM_FREE;// Amount of available memory [KBs]
	String SWAP_TOTAL;// Total amount of swap space displayed in KBs [KBs]
	String SWAP_FREE;// Amount of available swap memory
	String MEM_BUFFERS;// Amount of buffered memory [KBs]
	String MEM_SHARED; // Amount of shared memory
	String MEM_CACHED;// Amount of cached memory [KBs]

	String PROC_TOTAL;// Total number of processes
	String PROC_RUN;// Total number of running processes

	String PKTS_IN;// Packets in per second [packets/sec]
	String PKTS_OUT;// Packets out per second [packets/sec]
	String BYTES_IN;// Number of bytes in per second [bytes/sec]
	String BYTES_OUT;// Number of bytes out per second [bytes/sec]

	String LOAD_ONE;// One minute load average
	String LOAD_FIVE;// Five minute load average
	String LOAD_FIFTEEN;// Fifteen minute load average

	String DISK_TOTAL;// Total available disk space [GBs]
	String DISK_FREE;// Total free disk space [GBs]

	Date UPDATE_TIME;

	public String getUUID() {
		return UUID;
	}

	public void setUUID(String uUID) {
		UUID = uUID;
	}

	public String getIPADDR() {
		return IPADDR;
	}

	public void setIPADDR(String iPADDR) {
		IPADDR = iPADDR;
	}

	public String getMACHINE_TYPE() {
		return MACHINE_TYPE;
	}

	public void setMACHINE_TYPE(String mACHINE_TYPE) {
		MACHINE_TYPE = mACHINE_TYPE;
	}

	public String getOS_RELEASE() {
		return OS_RELEASE;
	}

	public void setOS_RELEASE(String oS_RELEASE) {
		OS_RELEASE = oS_RELEASE;
	}

	public String getCPU_USER() {
		return CPU_USER;
	}

	public void setCPU_USER(String cPU_USER) {
		CPU_USER = cPU_USER;
	}

	public String getCPU_SYSTEM() {
		return CPU_SYSTEM;
	}

	public void setCPU_SYSTEM(String cPU_SYSTEM) {
		CPU_SYSTEM = cPU_SYSTEM;
	}

	public String getCPU_WIO() {
		return CPU_WIO;
	}

	public void setCPU_WIO(String cPU_WIO) {
		CPU_WIO = cPU_WIO;
	}

	public String getCPU_NUM() {
		return CPU_NUM;
	}

	public void setCPU_NUM(String cPU_NUM) {
		CPU_NUM = cPU_NUM;
	}

	public String getCPU_SPEED() {
		return CPU_SPEED;
	}

	public void setCPU_SPEED(String cPU_SPEED) {
		CPU_SPEED = cPU_SPEED;
	}

	public String getCPU_IDLE() {
		return CPU_IDLE;
	}

	public void setCPU_IDLE(String cPU_IDLE) {
		CPU_IDLE = cPU_IDLE;
	}

	public String getCPU_NICE() {
		return CPU_NICE;
	}

	public void setCPU_NICE(String cPU_NICE) {
		CPU_NICE = cPU_NICE;
	}

	public String getMEM_TOTAL() {
		return MEM_TOTAL;
	}

	public void setMEM_TOTAL(String mEM_TOTAL) {
		MEM_TOTAL = mEM_TOTAL;
	}

	public String getMEM_FREE() {
		return MEM_FREE;
	}

	public void setMEM_FREE(String mEM_FREE) {
		MEM_FREE = mEM_FREE;
	}

	public String getSWAP_TOTAL() {
		return SWAP_TOTAL;
	}

	public void setSWAP_TOTAL(String sWAP_TOTAL) {
		SWAP_TOTAL = sWAP_TOTAL;
	}

	public String getSWAP_FREE() {
		return SWAP_FREE;
	}

	public void setSWAP_FREE(String sWAP_FREE) {
		SWAP_FREE = sWAP_FREE;
	}

	public String getMEM_BUFFERS() {
		return MEM_BUFFERS;
	}

	public void setMEM_BUFFERS(String mEM_BUFFERS) {
		MEM_BUFFERS = mEM_BUFFERS;
	}

	public String getMEM_SHARED() {
		return MEM_SHARED;
	}

	public void setMEM_SHARED(String mEM_SHARED) {
		MEM_SHARED = mEM_SHARED;
	}

	public String getMEM_CACHED() {
		return MEM_CACHED;
	}

	public void setMEM_CACHED(String mEM_CACHED) {
		MEM_CACHED = mEM_CACHED;
	}

	public String getPROC_TOTAL() {
		return PROC_TOTAL;
	}

	public void setPROC_TOTAL(String pROC_TOTAL) {
		PROC_TOTAL = pROC_TOTAL;
	}

	public String getPROC_RUN() {
		return PROC_RUN;
	}

	public void setPROC_RUN(String pROC_RUN) {
		PROC_RUN = pROC_RUN;
	}

	public String getPKTS_IN() {
		return PKTS_IN;
	}

	public void setPKTS_IN(String pKTS_IN) {
		PKTS_IN = pKTS_IN;
	}

	public String getPKTS_OUT() {
		return PKTS_OUT;
	}

	public void setPKTS_OUT(String pKTS_OUT) {
		PKTS_OUT = pKTS_OUT;
	}

	public String getLOAD_ONE() {
		return LOAD_ONE;
	}

	public void setLOAD_ONE(String lOAD_ONE) {
		LOAD_ONE = lOAD_ONE;
	}

	public String getLOAD_FIVE() {
		return LOAD_FIVE;
	}

	public void setLOAD_FIVE(String lOAD_FIVE) {
		LOAD_FIVE = lOAD_FIVE;
	}

	public String getLOAD_FIFTEEN() {
		return LOAD_FIFTEEN;
	}

	public void setLOAD_FIFTEEN(String lOAD_FIFTEEN) {
		LOAD_FIFTEEN = lOAD_FIFTEEN;
	}

	public String getDISK_TOTAL() {
		return DISK_TOTAL;
	}

	public void setDISK_TOTAL(String dISK_TOTAL) {
		DISK_TOTAL = dISK_TOTAL;
	}

	public String getDISK_FREE() {
		return DISK_FREE;
	}

	public void setDISK_FREE(String dISK_FREE) {
		DISK_FREE = dISK_FREE;
	}

	public String getBYTES_IN() {
		return BYTES_IN;
	}

	public void setBYTES_IN(String bYTES_IN) {
		BYTES_IN = bYTES_IN;
	}

	public String getBYTES_OUT() {
		return BYTES_OUT;
	}

	public void setBYTES_OUT(String bYTES_OUT) {
		BYTES_OUT = bYTES_OUT;
	}

	public Date getUPDATE_TIME() {
		return UPDATE_TIME;
	}

	public void setUPDATE_TIME(Date uPDATE_TIME) {
		UPDATE_TIME = uPDATE_TIME;
	}

	public String getHOSTNAME() {
		return HOSTNAME;
	}

	public void setHOSTNAME(String hOSTNAME) {
		HOSTNAME = hOSTNAME;
	}

}

package extension.actions;

import extension.vo.SelectVO;

//试探类型卡牌接口
public interface IProbeAction {
	void ProbeChoosed(SelectVO svo);  //试探选择完成
	void DiscardResult(SelectVO svo);
}

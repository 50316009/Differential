package differential;

public class Differential {
	
	private double h, df[],cdf[], a;
	private int index = 0, cindex = 0;; //数値微分と理論値の絶対誤差が一番小さくなるdfのインデックス

	public Differential() {
		this.h = 0.1;	//h = 0.1 -> 10^-12
		this.df = new double[12];
		this.cdf = new double[12];
		this.a = Math.PI/3;
	}

	public void calDf() {
		
		double absolute = 100;
		for(int i = 0; i < df.length; i++){
			df[i] = (Math.sin(a + h) - Math.sin(a))/h;
			h *= 0.1;
			
			if(Math.abs(df[i] - 0.5) < absolute ){
				absolute = Math.abs(df[i] - 0.5);
				index = i;
			}
			
		}
	}
	
	public void calCdf(){
		double absolute = 100;
		for(int i = 0; i < cdf.length; i++){
			cdf[i] = (Math.sin(a + h) - Math.sin(a - h))/(2*h);
			h *= 0.1;
			
			if(Math.abs(cdf[i] - 0.5) < absolute ){
				absolute = Math.abs(cdf[i] - 0.5);
				cindex = i;
			}	
		}
		
	}

	public double[] getCdf() {
		return cdf;
	}

	public int getCindex() {
		return cindex;
	}

	public double[] getDf() {
		return df;
	}

	public int getIndex() {
		return index;
	}
	
	
	

}

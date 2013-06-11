/*
 * HYPE_Processing
 * http:
 * 
 * Copyright (c) 2013 Joshua Davis & James Cruz
 * 
 * Distributed under the BSD License. See LICENSE.txt for details.
 * 
 * All rights reserved.
 */
public static class HVertex implements HLocatable {
	private HPath _path;
	private byte _numControlPts;
	private float _u, _v, _cu1, _cv1, _cu2, _cv2;
	public HVertex(HPath parentPath) {
		_path = parentPath;
	}
	public HVertex createCopy(HPath newParentPath) {
		HVertex copy = new HVertex(newParentPath);
		copy._numControlPts = _numControlPts;
		copy._u = _u;
		copy._v = _v;
		copy._cu1 = _cu1;
		copy._cv1 = _cv1;
		copy._cu2 = _cu2;
		copy._cv2 = _cv2;
		return copy;
	}
	public HPath path() {
		return _path;
	}
	public HVertex numControlPts(byte b) {
		_numControlPts = b;
		return this;
	}
	public byte numControlPts() {
		return _numControlPts;
	}
	public boolean isLine() {
		return (_numControlPts <= 0);
	}
	public boolean isCurved() {
		return (_numControlPts > 0);
	}
	public boolean isQuadratic() {
		return (_numControlPts == 1);
	}
	public boolean isCubic() {
		return (_numControlPts >= 2);
	}
	public HVertex set(float x, float y) {
		return setUV(
			_path.x2u(x),   _path.y2v(y));
	}
	public HVertex set(float cx, float cy, float x, float y) {
		return setUV(
			_path.x2u(cx), _path.y2v(cy),
			_path.x2u(x),  _path.y2v(y));
	}
	public HVertex set(
		float cx1, float cy1,
		float cx2, float cy2,
		float x, float y
	) {
		return setUV(
			_path.x2u(cx1), _path.y2v(cy1),
			_path.x2u(cx2), _path.y2v(cy2),
			_path.x2u(x),   _path.y2v(y));
	}
	public HVertex setUV(float u, float v) {
		_numControlPts = 0;
		_u = u;
		_v = v;
		return this;
	}
	public HVertex setUV(float cu, float cv, float u, float v) {
		_numControlPts = 1;
		_u = u;
		_v = v;
		_cu1 = cu;
		_cv1 = cv;
		return this;
	}
	public HVertex setUV(
		float cu1, float cv1,
		float cu2, float cv2,
		float u, float v
	) {
		_numControlPts = 2;
		_u = u;
		_v = v;
		_cu1 = cu1;
		_cv1 = cv1;
		_cu2 = cu2;
		_cv2 = cv2;
		return this;
	}
	public HVertex x(float f) {
		return u(_path.x2u(f));
	}
	public float x() {
		return _path.u2x(_u);
	}
	public HVertex y(float f) {
		return v(_path.y2v(f));
	}
	public float y() {
		return _path.v2y(_v);
	}
	public HVertex z(float f) {
		return this;
	}
	public float z() {
		return 0;
	}
	public HVertex u(float f) {
		_u = f;
		return this;
	}
	public float u() {
		return _u;
	}
	public HVertex v(float f) {
		_v = f;
		return this;
	}
	public float v() {
		return _v;
	}
	public HVertex cx(float f) {
		return cx1(f);
	}
	public float cx() {
		return cx1();
	}
	public HVertex cy(float f) {
		return cy1(f);
	}
	public float cy() {
		return cy1();
	}
	public HVertex cu(float f) {
		return cu1(f);
	}
	public float cu() {
		return cu1();
	}
	public HVertex cv(float f) {
		return cv1(f);
	}
	public float cv() {
		return cv1();
	}
	public HVertex cx1(float f) {
		return cu1(_path.x2u(f));
	}
	public float cx1() {
		return _path.u2x(_cu1);
	}
	public HVertex cy1(float f) {
		return cv1(_path.y2v(f));
	}
	public float cy1() {
		return _path.v2y(_cv1);
	}
	public HVertex cu1(float f) {
		_cu1 = f;
		return this;
	}
	public float cu1() {
		return _cu1;
	}
	public HVertex cv1(float f) {
		_cv1 = f;
		return this;
	}
	public float cv1() {
		return _cv1;
	}
	public HVertex cx2(float f) {
		return cu2(_path.x2u(f));
	}
	public float cx2() {
		return _path.u2x(_cu2);
	}
	public HVertex cy2(float f) {
		return cv2(_path.y2v(f));
	}
	public float cy2() {
		return _path.v2y(_cv2);
	}
	public HVertex cu2(float f) {
		_cu2 = f;
		return this;
	}
	public float cu2() {
		return _cu2;
	}
	public HVertex cv2(float f) {
		_cv2 = f;
		return this;
	}
	public float cv2() {
		return _cv2;
	}
	public void computeMinMax(float[] minmax) {
		if(_u < minmax[0]) minmax[0] = _u;
		else if(_u > minmax[2]) minmax[2] = _u;
		if(_v < minmax[1]) minmax[1] = _v;
		else if(_v > minmax[3]) minmax[3] = _v;
		if(_numControlPts > 0) {
			if(_cu1 < minmax[0]) minmax[0] = _cu1;
			else if(_cu1 > minmax[2]) minmax[2] = _cu1;
			if(_cv1 < minmax[1]) minmax[1] = _cv1;
			else if(_cv1 > minmax[3]) minmax[3] = _cv1;
			if(_numControlPts > 1) {
				if(_cu2 < minmax[0]) minmax[0] = _cu2;
				else if(_cu2 > minmax[2]) minmax[2] = _cu2;
				if(_cv2 < minmax[1]) minmax[1] = _cv2;
				else if(_cv2 > minmax[3]) minmax[3] = _cv2;
			}
		}
	}
	public void adjust(float offU, float offV, float scaleW, float scaleH) {
		_u += offU;
		_cu1 += offU;
		_cu2 += offU;
		if(scaleW != 0) {
			_u /= scaleW;
			_cu1 /= scaleW;
			_cu2 /= scaleW;
		}
		_v += offV;
		_cv1 += offV;
		_cv2 += offV;
		if(scaleH != 0) {
			_v /= scaleH;
			_cv1 /= scaleH;
			_cv2 /= scaleH;
		}
	}
	private float dv(float pv, float t) {
		float tanv;
		switch(_numControlPts) {
		case 1:
			tanv = HMath.bezierTangent(pv,_cv1,_v, t);
			return tanv;
		case 2:
			tanv = HMath.bezierTangent(pv,_cv2,_cv2,_v, t);
			return tanv;
		default: return _v - pv;
		}
	}
	public boolean intersectTest(HVertex pprev,HVertex prev,float tu,float tv) {
		float u1 = prev._u;
		float v1 = prev._v;
		float u2 = _u;
		float v2 = _v;
		if(isLine()) {
			return ((v1<=tv && tv<v2) || (v2<=tv && tv<v1)) && 
				tu < (u1 + (u2-u1)*(tv-v1)/(v2-v1));
		} else if(isQuadratic()) {
			boolean b = false;
			float[] params = new float[2];
			int numParams = HMath.bezierParam(v1,_cv1,v2, tv, params);
			for(int i=0; i<numParams; ++i) {
				float t = params[i];
				if(0<t && t<1 && tu<HMath.bezierPoint(u1,_cu1,u2, t)) {
					if(HMath.bezierTangent(v1,_cv1,v2, t) == 0) continue;
					b = !b;
				} else if(t==0 && tu<u1) {
					float ptanv = prev.dv(pprev._v,1);
					if(ptanv==0) ptanv = prev.dv(pprev._v,0.9375f);
					float ntanv = HMath.bezierTangent(v1,_cv1,v2, 0);
					if(ntanv==0) ntanv=HMath.bezierTangent(v1,_cv1,v2, 0.0625f);
					if(ptanv<0 == ntanv<0) b = !b;
				}
			}
			return b;
		} else {
			boolean b = false;
			float[] params = new float[3];
			int numParams = HMath.bezierParam(v1,_cv1,_cv2,v2, tv, params);
			for(int i=0; i<numParams; ++i) {
				float t = params[i];
				if(0<t && t<1 && tu<HMath.bezierPoint(u1,_cu1,_cu2,u2, t)) {
					if(HMath.bezierTangent(v1,_cv1,_cv2,_v, t) == 0) {
						float ptanv = HMath.bezierTangent(
							v1,_cv1,_cv2,v2, Math.max(t-0.0625f, 0));
						float ntanv = HMath.bezierTangent(
							v1,_cv1,_cv2,v2, Math.min(t+.0625f, 1));
						if(ptanv<0 != ntanv<0) continue;
					}
					b = !b;
				} else if(t==0 && tu<u1) {
					float ptanv = prev.dv(pprev._v,1);
					if(ptanv==0) ptanv = prev.dv(pprev._v,0.9375f);
					float ntanv = HMath.bezierTangent(v1,_cv1,_cv2, 0);
					if(ntanv==0) ntanv = HMath.bezierTangent(
						v1,_cv1,_cv2,v2, 0.0625f);
					if(ptanv<0 == ntanv<0) b = !b;
				}
			}
			return b;
		}
	}
	public void draw( PGraphics g, float drawX, float drawY, boolean isSimple) {
		float drx = drawX + x();
		float dry = drawY + y();
		if(isLine() || isSimple) {
			g.vertex(drx, dry);
		} else if(isQuadratic()) {
			float drcx = drawX + cx1();
			float drcy = drawY + cy1();
			g.quadraticVertex(drcx,drcy, drx,dry);
		} else {
			float drcx1 = drawX + cx1();
			float drcy1 = drawY + cy1();
			float drcx2 = drawX + cx2();
			float drcy2 = drawY + cy2();
			g.bezierVertex(drcx1,drcy1, drcx2,drcy2, drx,dry);
		}
	}
}

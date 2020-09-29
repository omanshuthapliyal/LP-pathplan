function theta = angleBetween(u,v)
% finds the angle between the two vectors u & v
cosTheta = max(min(dot(u,v)/(norm(u)*norm(v)),1),-1);
theta = real(acos(cosTheta));
end